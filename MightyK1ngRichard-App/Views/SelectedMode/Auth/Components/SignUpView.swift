//
//  SignUpView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 03.07.2023.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @EnvironmentObject var selected : SelectedButton
    
    @State private var email        = ""
    @State private var password     = ""
    @State private var userIsSignIn = false
    var body: some View {
        if userIsSignIn {
            DogsViewTemp()
                
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            BackgoundShapes()
            
            InputView()
            
            Buttons()
        }
        .ignoresSafeArea()
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    self.userIsSignIn.toggle()
                    print("USER: ", user)
                }
                print("AUTH: ", auth)
            }
        }
    }
    
    @ViewBuilder
    private func BackgoundShapes() -> some View {
        Color.black
        
        Rectangle()
            .fill(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
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
                // ? sign up
                SignIn()
                
            } label: {
                Text("Sign Up")
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
                // ? sign in
                
            } label: {
                Text("Already have account? Login")
                    .foregroundColor(.white)
                    .font(.caption)
                    .bold()
            }
        }
        .offset(y: 200)
    }
    
    private func SignUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("==> ERROR FROM SIGN UP: \(error.localizedDescription)")
                return
            }
            if let result = result {
                print(result)
            }
        }
    }
    
    private func SignIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("==> ERROR FROM SIGN IN: \(error.localizedDescription)")
                return
            }
            if let result = result {
                print("SUCCESS")
                print(result)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
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
