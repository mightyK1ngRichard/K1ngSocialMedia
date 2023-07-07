//
//  AuthView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 03.07.2023.
//

import SwiftUI
import Firebase


struct AuthView: View {
    @EnvironmentObject var authData   : AuthDataManager
    @EnvironmentObject var selected   : SelectedButton
    
    @State private var showSignInView = false
    @State private var showAlert      = false
    
    var body: some View {
        VStack {
            if authData.userIsAuth {
//                Text("User is auth \(authData.user?.uid ?? "")")
//                Text("User is auth \(authData.user?.email ?? "")")
                // TODO: Сделать что-то с этим.
                
                SelecteMenuPoint()
                
            } else {
                /// Это авторизация или аутенфикация.
                SignUpView(showAlert: $showAlert, showSignInView: $showSignInView)
            }
        }
    }
    
    @ViewBuilder
    private func SelecteMenuPoint() -> some View {
        switch(selected.selectedButton.text) {
            
        case .profile:
            ProfileView(userID: UInt(1))
            
        case .news:
            NewsView()
            
        case .messages:
            MessagesView()
//            UploadImageToServer()
            
        case .friends:
            MovableGrid()
        
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(DataManager())
            .environmentObject(AuthDataManager())
            .environmentObject(SelectedButton())
            .preferredColorScheme(.dark)
    }
}
