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
            print("DEBUG: Failed to delete user: \(error)")
        }
        
        signOut()
    }
}

// MARK: - Firestore
extension NetworkManager {
    func fetchData() async {
        guard let movies = await loadData(of: .movies) as? [Movie], !movies.isEmpty else { return }
        guard let series = await loadData(of: .series) as? [Series], !series.isEmpty else { return }
        let data = Media(movies: movies, series: series)
        self.currentPage = Page(data: data)
    }
    
    func loadData(of type: DataType, limit: Int = 20) async -> [Any] {
        guard let uid = auth.currentUser?.uid else { return [] }
        guard let historySnapshot = try? await db.collection("users").document(uid).collection("\(type.rawValue)_history").getDocuments()
        else { return [] }
        let history = historySnapshot.documents.map { $0.documentID }
        
        let query = db.collection(type.rawValue)
            .order(by: "votes.kp", descending: true)
            .limit(to: limit)
        
        guard let snapshot = try? await query.getDocuments() else { return [] }
        
        let data: [Any]
        
        switch type {
        case .movies:
            data = snapshot.documents.map { try! $0.data(as: Movie.self) }
        case .series:
            data = snapshot.documents.map { try! $0.data(as: Series.self) }
        }
        
        return data
    }
    
    func writeChoice(of card: Card, with type: DataType) async {
        guard let uid = auth.currentUser?.uid else { return }
        
        switch type {
        case .movies:
            let data = card.movie
            do {
                let snapshot = try? await db.collection(type.rawValue).whereField("externalID.imdb", isEqualTo: data.externalID.imdb).getDocuments()
                let id = snapshot?.documents.map { $0.documentID }[0] ?? ""
                try await db.collection(type.rawValue).document(id).delete()
                try db.collection("users").document(uid).collection("\(type.rawValue)_history").addDocument(from: data)
            } catch {
                print("DEBUG: Failed to transfer data")
            }
        case .series:
            let data = card.series
            do {
                let snapshot = try? await db.collection(type.rawValue).whereField("externalID.imdb", isEqualTo: data.externalID.imdb).getDocuments()
                let id = snapshot?.documents.map { $0.documentID }[0] ?? ""
                try await db.collection(type.rawValue).document(id).delete()
                try db.collection("users").document(uid).collection("\(type.rawValue)_history").addDocument(from: data)
            } catch {
                print("DEBUG: Failed to transfer data")
            }
        }
    }
    
    func checkCount(of type: DataType) async {
        do {
            let snapshot = try await db.collection(type.rawValue).count.getAggregation(source: .server)
            print("DEBUG: Data count = \(snapshot.count)")
        } catch {
            print(error)
        }
    }
}

// MARK: - DataType Enum
enum DataType: String {
    case movies = "movies"
    case series = "series"
    
    func getOpposite() -> DataType {
        switch self {
        case .movies:
            return .series
        case .series:
            return .movies
        }
    }
}
