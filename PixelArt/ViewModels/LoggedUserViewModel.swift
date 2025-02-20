import FirebaseAuth
import FirebaseFirestore

@MainActor
class LoggedUserViewModel: ObservableObject {
    @Published var session: FirebaseAuth.User?
    @Published var user: User?
    @Published var authError: String?
    @Published var userPictures: [PixelPictureData] = []
    
    let db = Firestore.firestore()
    let usersCollectionName = "users"
    
    init() {
        session = Auth.auth().currentUser
    }

    func signIn(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            session = authResult.user
            await getUserData(uid: authResult.user.uid)
        } catch {
            authError = "Failed to sign in: \(error.localizedDescription)"
        }
    }
    
    private func getUserData(uid: String) async {
        do {
            self.user = try await db.collection(self.usersCollectionName).document(uid).getDocument(as: User.self)
        } catch {
            authError = "Failed to sign in: \(error.localizedDescription)"
        }
    }
    
    func register(username: String, email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            session = authResult.user
            self.user = User(id: session!.uid, username: username, email: email, createdOn: Date(), completedPixelArts: [])
            
            try await createNewUser(user: user!)
        } catch {
            authError = "Failed to register: \(error.localizedDescription)"
        }
    }
    
    private func createNewUser(user: User) async throws {
        try db.collection("users").document(self.session!.uid).setData(from: user)
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
            self.user = nil
        } catch {
            authError = "Failed to log out: \(error.localizedDescription)"
        }
    }
    
    func savePictureForCurrentUser(picture: PixelPictureData) {
            guard let uid = session?.uid else {
                authError = "User is not authenticated."
                return
            }
            
            do {
                let documentRef = db.collection(usersCollectionName)
                    .document(uid)
                    .collection("startedPictures")
                    .document(picture.id)
                
                try documentRef.setData(from: picture)
            } catch {
                authError = "Failed to save picture: \(error.localizedDescription)"
            }
        }
    
    func fetchUserPictures() async {
            guard let uid = session?.uid else {
                authError = "User is not authenticated."
                return
            }
            
            do {
                let snapshot = try await db.collection(usersCollectionName)
                    .document(uid)
                    .collection("startedPictures")
                    .getDocuments()
                
                self.userPictures = try snapshot.documents.compactMap {
                    try $0.data(as: PixelPictureData.self)
                }
            } catch {
                authError = "Failed to fetch pictures: \(error.localizedDescription)"
            }
        }
    
    func resetErrorStatus() {
        authError = ""
    }
}
