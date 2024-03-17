import Foundation
import Firebase
import FirebaseFirestore

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let jsonDecoder = JSONDecoder()
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    
    private init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
}


// MARK: - Authentication
extension NetworkManager {
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
            try await db.collection(CollectionType.users.rawValue).document(user.id).setData(encodedUser)
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
            try await db.collection(CollectionType.users.rawValue).document(id).delete()
        } catch {
            print("DEBUG: Failed to delete user: \(error)")
        }
        
        signOut()
    }
    
    func fetchUser() async {
        guard let uid = auth.currentUser?.uid else { return }
        
        guard let snapshot = try? await db.collection(CollectionType.users.rawValue).document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}

// MARK: - Firestore
extension NetworkManager {
    func checkMoviesCount() async {
        do {
            let snapshot = try await db.collection(CollectionType.movies.rawValue).count.getAggregation(source: .server)
            print("DEBUG: Movies count = \(snapshot.count)")
        } catch {
          print(error)
        }
    }
    
    func checkSeriesCount() async {
        do {
            let snapshot = try await db.collection(CollectionType.series.rawValue).count.getAggregation(source: .server)
            print("DEBUG: Series count = \(snapshot.count)")
        } catch {
          print(error)
        }
    }
}

// MARK: - CollectionType Enum
private enum CollectionType: String {
    case users = "users"
    case movies = "movies"
    case series = "series"
}
