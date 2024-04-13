import Foundation
import Firebase
import FirebaseFirestore

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    var currentPage: Page?
    var iterator = Iterator()
    
    private init() {
        self.userSession = auth.currentUser
        
        Task {
            await fetchUser()
        }
    }
}

// MARK: - Authentication
extension NetworkManager {
    func fetchUser() async {
        guard let uid = auth.currentUser?.uid else { return }
        guard let snapshot = try? await db.collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, nickname: String) async throws {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, nickname: nickname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await db.collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        guard let user = auth.currentUser, let id = auth.currentUser?.uid else { return }
        
        do {
            try await user.delete()
            try await db.collection("users").document(id).delete()
        } catch {
            print("DEBUG: Failed to delete user: \(error.localizedDescription)")
        }
        
        signOut()
    }
}

// MARK: - Firestore
extension NetworkManager {
    func loadData(with filter: Filter? = nil) async {
        let movies = await fetchData(of: .movies, filter: filter)
        let series = await fetchData(of: .series, filter: filter)
        let data = MediaData(movies: movies, series: series)
        self.currentPage = Page(data: data)
        self.iterator.reset()
    }
    
    func searchData(with keyword: String) async -> [Media] {
        // MARK: Construct query
        let query = db.collection("media").limit(to: 20).whereField("keywords", arrayContains: keyword)
        
        // MARK: Execute Query
        var data: [Media]
        
        do {
            let snapshot = try await query.getDocuments()
            data = try snapshot.documents.map { try $0.data(as: Media.self) }
        } catch {
            print("DEBUG: Failed to search data, error: \(error.localizedDescription)")
            return []
        }
        
        return data
    }
    
    func fetchData(of type: MediaType, limit: Int = 20, filter: Filter? = nil) async -> [Media] {
        // MARK: Construct query
        var query = db.collection("media").limit(to: limit)
        
        switch type {
        case .movies:
            query = query.whereField("isMovie", isEqualTo: true)
        case .series:
            query = query.whereField("isMovie", isEqualTo: false)
        }
        
        if let yearFilter = filter?.years {
            query = query.whereField("year", isGreaterThanOrEqualTo: yearFilter.left)
                    .whereField("year", isLessThanOrEqualTo: yearFilter.right)
        }
        
        if let genreFilter = filter?.genre {
            query = query.whereFilter(FirebaseFirestoreInternal.Filter.orFilter([
                FirebaseFirestoreInternal.Filter.whereField("genres.en", arrayContains: genreFilter),
                FirebaseFirestoreInternal.Filter.whereField("genres.ru", arrayContains: genreFilter)
            ]))
        }
        
        // MARK: Execute Query
        var data: [Media]
        
        do {
            let snapshot = try await query.getDocuments()
            data = try snapshot.documents.map { try $0.data(as: Media.self) }
        } catch {
            print("DEBUG: Failed to fetch data, error: \(error.localizedDescription)")
            return []
        }
        
        if let ratingFilter = filter?.ratings {
            data = data.filter { $0.rating.imdb >= ratingFilter.left &&  $0.rating.imdb <= ratingFilter.right }
        }
        
        return data
    }
    
    func clearHistory() async {
        guard let uid = auth.currentUser?.uid else { return }
        let query = db.collection("users").document(uid).collection("history")
        
        do {
            let snapshot = try await query.getDocuments()
            let data = try snapshot.documents.map { try $0.data(as: Media.self) }
            
            for media in data {
                try db.collection("media").document(media.externalID.imdb).setData(from: media)
                try await db.collection("media").document(media.externalID.imdb).updateData(["keywords": media.keywords])
                try await db.collection("users").document(uid).collection("history").document(media.externalID.imdb).delete()
            }
            
            print("DEBUG: History deleted")
        } catch {
            print("DEBUG: Failed to clear data, error: \(error.localizedDescription)")
        }
    }
    
    func writeChoice(of card: Card, with type: MediaType) async {
        guard let uid = auth.currentUser?.uid else { return }
        let data = type == .movies ? card.movie : card.series
        guard data.externalID.imdb != "" else { return }
        iterator.increase()
        
        do {
            // MARK: Delete card from general collection and transfer to user_history
            try await db.collection("media").document(data.externalID.imdb).delete()
            try db.collection("users").document(uid).collection("history").document(data.externalID.imdb).setData(from: data)
            
            // MARK: Load backup data if needed
            guard let currentCount = type == .movies ? currentPage?.data.movies.count : currentPage?.data.series.count else { return }
            if iterator.isReachedMiddle(of: currentCount) {
                var backup = await NetworkManager.shared.fetchData(of: type, limit: currentCount)
                backup.removeFirst(currentCount - currentCount / 2)
                
                switch type {
                case .movies:
                    currentPage?.data.movies.removeFirst(currentCount / 2)
                    currentPage?.data.movies.append(contentsOf: backup)
                case .series:
                    currentPage?.data.series.removeFirst(currentCount / 2)
                    currentPage?.data.series.append(contentsOf: backup)
                }
                
                iterator.reset()
                currentPage?.data.swiper.reset(for: type)
            }
        } catch {
            print("DEBUG: Failed to write swipe-choice")
            return
        }
    }
}
