//
//  DataManager.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 04.07.2023.
//

import Foundation
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

final class AuthDataManager: ObservableObject {
    @Published var user: FirebaseUserInfo?
    @Published var userIsAuth = false
    
    init() {
        CurrentStateAuth()
    }
    
    func CurrentStateAuth() {
        Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                self.userIsAuth = true
                self.user = .init(user: user)
            } else {
                self.userIsAuth = false
            }
        }
    }
    
    func SignOut() throws {
        do {
            try AuthService.shared.SignOut()
            
        } catch {
            throw error
        }
    }
}

// MARK: - Firebase service.
final class AuthService {
    static let shared = AuthService()
    
    private var auth  = Auth.auth()
    
    /// Авторизация.
    func SignUp(email: String, password: String) async throws -> FirebaseUserInfo {
        do {
            let authDataResult = try await auth.createUser(withEmail: email, password: password)
            return .init(user: authDataResult.user)
            
        } catch {
            throw error
        }
    }
    
    /// Аутенфикация.
    func SignIn(email: String, password: String) async throws -> FirebaseUserInfo {
        do {
            let authDataResult = try await auth.signIn(withEmail: email, password: password)
            return .init(user: authDataResult.user)
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func SignInWithGoogle() async throws -> FirebaseUserInfo {
        guard let topVC =  Utilities.shared.topViewController() else { throw URLError(.cannotFindHost) }
        let gidSignInResults = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResults.user.idToken?.tokenString else { throw URLError(.badServerResponse) }
        let accessToken = gidSignInResults.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        do {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            return .init(user: authDataResult.user)
            
        } catch {
            throw error
        }
        
    }
    
    /// Выход.
    func SignOut() throws {
        do {
            try auth.signOut()
            
        } catch {
            throw error
        }
    }
}


// MARK: - Структура юзера firebase.
struct FirebaseUserInfo {
    let uid      : String
    var email    : String?
    var photoURL : URL?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL
    }
}


