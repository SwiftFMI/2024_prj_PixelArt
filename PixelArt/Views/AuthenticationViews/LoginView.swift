import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @StateObject var loggedUserVM = LoggedUserViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Log in")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let error = loggedUserVM.authError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: loginUser) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            .disabled(isLoading)
            
            Spacer()
        }
        .padding()
    }
    
    private func loginUser() {
        isLoading = true
        Task {
            try await loggedUserVM.signIn(email: email, password: password)
            isLoading = false
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoggedUserViewModel())
}
