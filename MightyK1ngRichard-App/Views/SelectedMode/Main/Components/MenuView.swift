//
//  MenuView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var selected : SelectedButton
    @EnvironmentObject var authData : AuthDataManager
    
    let buttons  : [ButtonsBar]
    let nickname = "Дмитрий Пермяков"
    let link     = "@mightyk1ngrichard"
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                GeometryReader { _ in
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
                            
                            Button {
                                self.selected.showMenu = false
                                self.selected.selectedButton = .init(id: UUID(), text: .profile, image: "profile")
                                
                                do {
                                    try authData.SignOut()
                                    
                                } catch {
                                    print("error of sign out: \(error.localizedDescription)")
                                }
                                
                            } label: {
                                Label("Выход", systemImage: "rectangle.portrait.and.arrow.forward")
                                    .font(.title3)
                                    
                            }


                        }
                        .padding(.leading, 5)
                        .font(.title2)
                        .foregroundColor(colorScheme == .dark ? .white : .white)
                        
                    }
                }
                .frame(width: proxy.size.width * 0.6)
                .background(.black)
                .background(
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 0, blue: 0.980173409, alpha: 1)), radius: 20, x: -10, y: 0)
                        .ignoresSafeArea()
                )
                
                GeometryReader { _ in
                }
                .background(.primary.opacity(0.1))
                .onTapGesture {
                    selected.showMenu = false
                }
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
        MenuView(buttons: [
            .init(id: UUID(), text: .profile, image: "person"),
            .init(id: UUID(), text: .news, image: "note"),
            .init(id: UUID(), text: .messages, image: "message"),
            .init(id: UUID(), text: .friends, image: "person.2"),
        ])
        .environmentObject(SelectedButton())
//        .background(.yellow.opacity(0.1))
    }
}
