import SwiftUI
import Foundation
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var auth: Auth
    @StateObject var viewModel: LoginViewModel
    
    init(apiHostname: String) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(apiHostname: apiHostname))
    }
    
    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
            TextField("Email", text: $viewModel.username)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
            SecureField("Password", text: $viewModel.password)
                .padding()
                .padding(.horizontal)
            AsyncButton("Log In") {
                let loginData = try await viewModel.login()
                let token = try await viewModel.handleLoginComplete(loginData: loginData)
                auth.token = token
            }
            .frame(width: 120.0, height: 60.0)
            .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
            Spacer()
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                Task {
                    let loginData = try await viewModel.handleSIWA(result: result)
                    let token = try await viewModel.handleLoginComplete(loginData: loginData)
                    auth.token = token
                }
            }
            .padding()
            .frame(width: 250, height: 70)
            AsyncButton(image: "sign-in-with-google") {
                let loginData = try await viewModel.oauthSignInWrapper.signIn(with: .google)
                let token = try await viewModel.handleLoginComplete(loginData: loginData)
                auth.token = token
            }
            .padding()
            .frame(width: 250, height: 70)
            AsyncButton(image: "sign-in-with-github") {
                let loginData = try await viewModel.oauthSignInWrapper.signIn(with: .github)
                let token = try await viewModel.handleLoginComplete(loginData: loginData)
                auth.token = token
            }
            .padding()
            .frame(width: 250, height: 70)
        }
        .alert(isPresented: $viewModel.showingLoginErrorAlert) {
            Alert(title: Text("Error"), message: Text("Could not log in. Check your credentials and try again"))
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(apiHostname: "http://localhost:8080")
    }
}
