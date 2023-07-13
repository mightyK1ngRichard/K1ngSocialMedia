//
//  ContentView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var selected = SelectedButton()
    @StateObject var authData = AuthDataManager()
    
    private let buttons       : [ButtonsBar] = [
        .init(id: UUID(), text: .news,     image: "house"),
        .init(id: UUID(), text: .messages, image: "message"),
        .init(id: UUID(), text: .profile,  image: "person"),
        .init(id: UUID(), text: .friends,  image: "person.2"),
    ]
    
    var body: some View {
        ZStack{
            if authData.userIsAuth {
                SelecteMenuPoint()
                TabBarView(buttons: buttons)
                
                if selected.showMenu {
                    MenuView(buttons: buttons)
                        .zIndex(2)
                }
                
            } else {
                AuthView()
            }
        }
        .environmentObject(authData)
        .environmentObject(selected)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthDataManager())
            .environmentObject(SelectedButton())
            .preferredColorScheme(.dark)
    }
}

/*
 ZStack {
 if authData.userIsAuth {
 //                Text("User is auth \(authData.user?.uid ?? "")")
 //                Text("User is auth \(authData.user?.email ?? "")")
 // TODO: Сделать что-то с этим.
 
 SelecteMenuPoint()
 TabBarView(buttons: buttons)
 
 if selected.showMenu {
 MenuView(buttons: buttons)
 .zIndex(2)
 }
 
 } else {
 /// Это авторизация или аутенфикация.
 SignUpView(showAlert: $showAlert, showSignInView: $showSignInView)
 }
 }
 */
