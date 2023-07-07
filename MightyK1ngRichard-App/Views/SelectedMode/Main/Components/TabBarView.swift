//
//  TabBarView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 07.07.2023.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var selected: SelectedButton
    let buttons: [ButtonsBar]
    @State private var didFinishAnimation = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            Divider()
                .background(.white)
            
            let countOfRepeating = buttons.count
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: countOfRepeating)) {
                ForEach(buttons) { button in
                    buttonView(button)
                }
            }
            .padding(.top, 5)
            .background(Color.VK.black)
            //            .background(.black.opacity(0.4))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    @ViewBuilder
    private func buttonView(_ button: ButtonsBar) -> some View {
        let isSelected = selected.selectedButton.text == button.text
        
        VStack(spacing: 6) {
            Image(systemName: button.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
            Text(button.text.rawValue)
                .font(.caption2)
        }
        .foregroundColor(isSelected ? .white : .white.opacity(0.5))
        .frame(height: 45)
        .scaleEffect(isSelected && didFinishAnimation ? 1.1 : 1)
        .onTapGesture {
            withAnimation {
                selected.selectedButton.text = button.text
                didFinishAnimation = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    didFinishAnimation = false
                }
            }
        }
//        .overlay(alignment: .top) {
//            if isSelected {
//                Circle()
//                    .frame(width: 6, height: 6)
//                    .foregroundColor(.white)
//                    .offset(y: -8)
//            }
//        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(buttons: [
            .init(id: UUID(), text: .news, image: "house"),
            .init(id: UUID(), text: .messages, image: "message"),
            .init(id: UUID(), text: .friends, image: "person.2"),
            .init(id: UUID(), text: .profile, image: "person"),
        ])
        .environmentObject(SelectedButton())
    }
}
