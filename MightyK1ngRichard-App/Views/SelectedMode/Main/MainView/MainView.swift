//
//  MainView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var selected = SelectedButton()
    @State private var buttons   : [ButtonsBar] = [
        .init(id: UUID(), text: .profile, image: "person"),
        .init(id: UUID(), text: .news, image: "note"),
        .init(id: UUID(), text: .messages, image: "message"),
        .init(id: UUID(), text: .friends, image: "person.2"),
    ]
    
    var body: some View {
        ZStack {
            MainScreen()
            
            if selected.showMenu {
                MenuView(buttons: $buttons)
                    .zIndex(2)
            }
        }
        .environmentObject(selected)
    }
    
    @ViewBuilder
    private func MainScreen() -> some View {
        switch(selected.selectedButton.text) {
        case .profile:
            ProfileView(userID: UInt(1))
            
        case .news:
            NewsView()
            
        case .messages:
//            FirstTraining()
            UploadImageToServer()
            
        case .friends:
            MovableGrid()
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var selected = SelectedButton()
        MainView()
            .environmentObject(selected)
            .preferredColorScheme(.dark)
    }
}
