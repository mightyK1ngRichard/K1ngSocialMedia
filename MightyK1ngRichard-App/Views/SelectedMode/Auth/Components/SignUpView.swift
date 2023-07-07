//
//  SignUpView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 03.07.2023.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift


struct SignUpView: View {
    @EnvironmentObject var authData : AuthDataManager
    
    @State private var email        = ""
    @State private var password     = ""
    @State private var errorMessage = ("", "")
    @Binding var showAlert          : Bool
    @Binding var showSignInView     : Bool
    
    var body: some View {
        content
            .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(errorMessage.0),
                        message: Text(errorMessage.1)
                    )
                }
    }
    
    var content: some View {
        ZStack {
            BackgoundShapes()
            
            InputView()
            
            Buttons()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func BackgoundShapes() -> some View {
        Color.black
        
        Rectangle()
            .fill(LinearGradient(colors: showSignInView ? [.mint, .blue] : [.pink, .purple] , startPoint: .topLeading, endPoint: .bottomTrailing))
            .rotationEffect(.degrees(45))
            .offset(x: -100, y: -130)
    }
    
    @ViewBuilder
    private func InputView() -> some View {
        Text("Welcome to\nK1ngSocialMedia")
            .foregroundColor(.white)
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .offset(y: -200)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        VStack(spacing: 20) {
            VStack(spacing: 0) {
                TextField("", text: $email)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal)
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 2, alignment: .center)
                    .foregroundColor(.white.opacity(0.4))
            }
            
            VStack(spacing: 0) {
                SecureField("", text: $password)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal)
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 2, alignment: .center)
                    .foregroundColor(.white.opacity(0.4))
                
                
            }
        }
    }
    
    @ViewBuilder
    private func Buttons() -> some View {
        VStack(spacing: 20) {
            Button {
                /// Если пользователь на вьюшке входа, то реализуем вход.
                if showSignInView {
                    Task {
                        await SignIn()
                    }
                    
                } else {
                    Task {
                        await SignUp()
                    }
                }
                
            } label: {
                Text(showSignInView ? "Sign In" : "Sign Up")
                    .padding(.horizontal, 36)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                
                                .linearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .foregroundColor(.white)
            }
            
            Button {
                self.showSignInView.toggle()
                
            } label: {
                Text(showSignInView ? "Don't have account? Register" : "Already have account? Login")
                    .foregroundColor(.white)
                    .font(.caption)
                    .bold()
            }
            
            GoogleButton()
        }
        .offset(y: 260)
        
    }
    
    private func GoogleButton() -> some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .icon, state: .normal)) {
            Task {
                do {
                    self.authData.user = try await AuthService.shared.SignInWithGoogle()
                    self.authData.userIsAuth = true
                    
                } catch {
                    print("error from sign in with google: \(error.localizedDescription)")
                    self.errorMessage.0 = "Ошибка авторизации"
                    self.errorMessage.1 = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
        .clipShape(Circle())
    }
    
    private func SignUp() async {
        do {
            let user = try await AuthService.shared.SignUp(email: email, password: password)
            self.authData.user = user
            self.authData.userIsAuth = true
            
        } catch {
            print("Error of create user: \(error.localizedDescription)")
            self.errorMessage.0 = "Ошибка авторизации"
            self.errorMessage.1 = error.localizedDescription
            self.password = ""
            self.showAlert = true
        }
    }
    
    private func SignIn() async {
        do {
            let user = try await AuthService.shared.SignIn(email: email, password: password)
            self.authData.user = user
            self.authData.userIsAuth = true
            
        } catch {
            print("Error of create user: \(error.localizedDescription)")
            self.errorMessage.0 = "Ошибка аутенфикации"
            self.errorMessage.1 = error.localizedDescription
            self.password = ""
            self.showAlert = true
        }
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
//        let showSignIn = false
        let showSignIn = true
        
        SignUpView(showAlert: .constant(false), showSignInView: .constant(showSignIn))
            .environmentObject(DataManager())
    }
}

extension View {
    func placeholder<Content:View>(
        when shouldShow: Bool, alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1: 0)
                self
            }
        }

}
