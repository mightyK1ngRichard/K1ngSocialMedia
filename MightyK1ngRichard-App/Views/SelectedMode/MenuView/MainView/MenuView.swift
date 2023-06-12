//
//  MenuView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var selected : SelectedButton
    @Binding var buttons            : [ButtonsBar]
    
    let nickname = "Дмитрий Пермяков"
    let link     = "@mightyk1ngrichard"
    
    var body: some View {
        HStack {
            VStack (spacing: 20) {
                HStack {
                    avatar()
                    VStack {
                        Text(nickname)
                            .font(.headline)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(link)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.leading, 3)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 20)
                
                ForEach(buttons) { button in
                    HStack {
                        Button {
                            // ?
                            selected.selectedButton.text = button.text
                            print("==> \(button.id) \(selected.selectedButton)")
                            
                        } label: {
                            Image(systemName: button.image)
                            
                            Text(button.text.rawValue)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                    .padding(.leading, 5)
                    
                }
                
                Spacer()
            }
            .font(.title2)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 5)
    }
    
    @ViewBuilder
    func avatar() -> some View {
        Image("k1ng")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 45, height: 45)
            .clipped()
            .overlay {
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.white)
            }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SelectedButton())
    }
}
