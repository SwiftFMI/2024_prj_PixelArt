import SwiftUI

struct MainUnregisteredScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Welcome to PixelArt!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Image(systemName: "paintbrush.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()
                
                Spacer()
                    
                NavigationLink(destination: LoginView()) {
                    Text("Log In")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainUnregisteredView()
}
