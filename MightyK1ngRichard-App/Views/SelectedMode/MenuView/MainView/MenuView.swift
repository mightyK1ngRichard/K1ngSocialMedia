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
        GeometryReader {
            let size = $0.size
            let width = size.width * 0.646
            let height = size.height
            
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
                        .foregroundColor(.primary)
                    }
                    .padding(.bottom, 20)
                    
                    ForEach(buttons) { button in
                        HStack {
                            Button {
                                // ?
                                selected.selectedButton.text = button.text
                                
                                
                            } label: {
                                Image(systemName: button.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .padding(.trailing, 8)
                                
                                Text(button.text.rawValue)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                        }
                        .padding(.leading, 5)
                        
                    }
                    Spacer()
                }
                .padding(.leading, 5)
                .font(.title2)
                .foregroundColor(.primary)
                .frame(width: width, height: height)
                .background(.black)
                .background(
                    Rectangle()
                        .frame(maxWidth: width, maxHeight: .infinity)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 0, blue: 0.980173409, alpha: 1)), radius: 20, x: -10, y: 0)
                        .ignoresSafeArea()
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.black.opacity(0.1))
            .onTapGesture {
                selected.showMenu = false
            }
        }
    }
    
    @ViewBuilder
    func avatar() -> some View {
        AsyncImage(url: URL(string: "https://ru-static.z-dn.net/files/df9/899fd190739b0985daa1921650cb9897.jpg")!) { image in
            
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundColor(.white)
                }
        } placeholder: {
            ProgressView()
                .padding(.trailing, 5)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(buttons: .constant([
            .init(id: UUID(), text: .profile, image: "person"),
            .init(id: UUID(), text: .news, image: "note"),
            .init(id: UUID(), text: .messages, image: "message"),
            .init(id: UUID(), text: .friends, image: "person.2"),
        ]))
        .environmentObject(SelectedButton())
        .background(.yellow.opacity(0.1))
    }
}
