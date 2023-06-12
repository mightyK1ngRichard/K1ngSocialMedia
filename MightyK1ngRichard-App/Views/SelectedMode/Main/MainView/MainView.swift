//
//  MainView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct MainView: View {
    @State private var buttons : [ButtonsBar] = [
        .init(id: UUID(), text: .profile, image: "person"),
        .init(id: UUID(), text: .news, image: "note"),
        .init(id: UUID(), text: .messages, image: "message"),
        .init(id: UUID(), text: .friends, image: "person.2"),
    ]
    @ObservedObject var selected = SelectedButton()
    
    var body: some View {
        ZStack {
            MainScreen()
                .onTapGesture {
                    DispatchQueue.main.async {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
                            selected.showMenu = false
                        }
                    }
                }
            
            if selected.showMenu {
                ButtonsView()
            }
            
        }
        .environmentObject(selected)
    }
    
    @ViewBuilder
    private func MainScreen() -> some View {
        switch(selected.selectedButton.text) {
        case .profile:
            ProfileView()
            
        case .news:
            NewsView()
            
        case .messages:
            MessagesView()
            
        case .friends:
            Text("Друзья")
                .foregroundColor(.yellow)
        }
    }
    
    @ViewBuilder
    private func ButtonsView() -> some View {
        let backgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8001862583)
        
        GeometryReader {
            let size = $0.size
            let width = size.width * 0.6
            let height = size.height
            
            MenuView(buttons: $buttons)
                .frame(width: width, height: height)
                .background(Color(backgroundColor))
                .background(
                    Rectangle()
                        .frame(maxWidth: width, maxHeight: .infinity)
                        .shadow(color: .white, radius: 45, x: -54, y: 0)
                        .ignoresSafeArea()
                )
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SelectedButton())
    }
}
