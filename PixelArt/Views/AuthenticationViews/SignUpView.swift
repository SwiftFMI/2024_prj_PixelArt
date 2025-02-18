import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @EnvironmentObject var loggedUserVM: LoggedUserViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            TextField("Email", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let error = loggedUserVM.authError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: signUpUser) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Sign up")
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
    
    private func signUpUser() {
        isLoading = true
        Task {
            try await loggedUserVM.register(email: email, password: password)
            isLoading = false
        }
    }
}
