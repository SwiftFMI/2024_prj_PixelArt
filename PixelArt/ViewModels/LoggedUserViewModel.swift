import FirebaseAuth
import FirebaseFirestore

class LoggedUserViewModel: ObservableObject {
    @Published var session: FirebaseAuth.User?
    @Published var authError: String?
    
    init() {
        self.session = Auth.auth().currentUser
    }

    func signIn(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.session = authResult.user
        } catch {
            authError = "Failed to sign in: \(error.localizedDescription)"
        }
    }
    
    func register(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.session = authResult.user
        } catch {
            authError = "Failed to register: \(error.localizedDescription)"
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            authError = "Failed to log out: \(error.localizedDescription)"
        }
    }
}
