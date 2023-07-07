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
    
    @State private var showAlert      = false
    @State private var showSignInView = false
    
    var body: some View {
        /// Это авторизация или аутенфикация.
        SignUpView(showAlert: $showAlert, showSignInView: $showSignInView)
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
