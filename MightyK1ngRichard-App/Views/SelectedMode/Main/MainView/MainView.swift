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
            }
        }
        .environmentObject(selected)
    }
    
    @ViewBuilder
    private func MainScreen() -> some View {
        switch(selected.selectedButton.text) {
        case .profile:
            let backImg = URL(string: "https://w-dog.ru/wallpapers/16/9/442689553177276/anime-iskusstvo-mahou-shoujo-madoka-magika-kaname-madoka-devushka-sidit-vzglyad-volshebnica-derevo-tron.jpg")!
            
            let userURL = URL(string: "https://proprikol.ru/wp-content/uploads/2020/05/kartinki-glaza-anime-53.jpg")!
            ProfileView(backroundImage: backImg, userAvatar: userURL)
            
        case .news:
            NewsView()
            
        case .messages:
            MessagesView()
            
        case .friends:
            Text("Друзья")
                .foregroundColor(.yellow)
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var selected = SelectedButton()
        MainView()
            .environmentObject(selected)
    }
}
