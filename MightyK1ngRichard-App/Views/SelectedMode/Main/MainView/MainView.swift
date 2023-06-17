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
            let backImg = URL(string: "https://d1lss44hh2trtw.cloudfront.net/assets/article/2023/01/09/apple-to-unveil-mixed-reality-headset-spring-2023-news_feature.jpg")!
            
            let userURL = URL(string: "https://ru-static.z-dn.net/files/df9/899fd190739b0985daa1921650cb9897.jpg")!
            ProfileView(backroundImage: backImg, userAvatar: userURL)
            
        case .news:
            NewsView()
            
        case .messages:
            FirstTraining()
            
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
