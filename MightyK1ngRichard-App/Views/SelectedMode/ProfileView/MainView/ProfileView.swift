//
//  ProfileView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var selected   : SelectedButton
    @State private var pressedButton = "Фото"
    
    var userPosts       = [
        ("2023-02-02", "Просто что-то про жизнь"),
        ("2023-02-02", "Просто что-то про жизнь"),
        ("2023-02-02", "Просто что-то про жизнь"),
        ("2023-02-02", "Просто что-то про жизнь")
    ]
    var image           = "k1ng"
    var nickname        = "Dmitriy Permyakov"
    var description     = " Engoing Web/iOS developing"
    var locationInfo    = "London"
    var backroundImage  = "wwdc"
    var backgroundColor : UIColor = #colorLiteral(red: 0.1105830893, green: 0.1105830893, blue: 0.1105830893, alpha: 1)
    var colorOfText     : Color = .white
    var countOfFriends  = "105" + " друзей"
    
    
    
    var body: some View {
        ScrollView {
            ScreenOfUser()
        }
        .background(Color(.black))
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func TopView() -> some View {
        VStack {
            VStack(spacing: 5) {
                Text(nickname)
                    .font(.system(.headline, weight: .black))
                    .scaleEffect(1.3)
                    .lineLimit(1)
                
                Text(description)
                    .font(.caption)
                
                HStack {
                    Image(systemName: "location")
                        .iconsSizes()
                    
                    Text(locationInfo)
                        .font(.caption)
                    
                    Image(systemName: "book")
                        .iconsSizes()
                    
                    Text("МГТУ им. Н.Э.Баумана")
                        .font(.caption)
                    
                    Image(systemName: "info.circle")
                        .iconsSizes()
                }
            }
            .padding()
            .padding(.top, 40)
            
            Button {
                // ?
                
            } label: {
                Text("Подписаться")
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .background(Color(.gray).opacity(0.5))
                    .cornerRadius(10)
                    .padding(.vertical, 5)
                    .foregroundColor(colorOfText)
                    .font(.headline)
            }
            .padding(.horizontal, 20)
            .padding(.bottom)
        }
        .foregroundColor(colorOfText)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(backgroundColor))
        .cornerRadius(20)
    }
    
    @ViewBuilder
    private func ScreenOfUser() -> some View {
        ZStack(alignment: .top) {
            Image(backroundImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack {
                ZStack(alignment: .top) {
                    Color(.black)
                        .offset(y: 20)
                    
                    VStack {
                        TopView()
                            .frame(height: 200)
                        DownView()
                        
                        imagesView()
                    }
                    
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundColor(Color(backgroundColor))
                        }
                        .padding(.bottom, 5)
                        .offset(y: -50)
                    // TODO: Убрать открытие меню по аве.
                        .onTapGesture {
                            DispatchQueue.main.async {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
                                    selected.showMenu = true
                                }
                            }
                        }
                    
                }
            }
            
            .padding(.top, 150)
        }
    }
    
    @ViewBuilder
    private func imagesView() -> some View {
        let buttons = [
            ("Фото", "photo"),
            ("Видео", "play.square"),
            ("Музыка", "airpodspro"),
            ("Клипы", "video"),
        ]
        
        VStack {
            // TODO: Сделать LazyHStack. Щас лень.
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(buttons, id: \.self.0) {
                        ButtonsOfModes(pressedButton: $pressedButton, img: $0.1, text: $0.0)
                    }
                }
            }
            .padding(.leading)
            .padding(.top)
            
            HStack {
                ForEach(0...2, id: \.self) { _ in
                    Image("k1ng")
                        .resizable()
                        .frame(width: 120, height: 120)
                }
            }
            
            HStack {
                Button {
                    // ?
                    
                } label: {
                    Image(systemName: "plus")
                    Text("Загрузить фото")
                }

                
                Divider()
                
                Button {
                    // ?
                    
                } label: {
                    Text("Загрузить фото")
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.bottom)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .background(Color(backgroundColor))
        .cornerRadius(20)
    }

    private func DownView() -> some View {
        VStack {
            Text(countOfFriends)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.vertical)
                .background(Color(backgroundColor))
                .foregroundColor(colorOfText)
                .cornerRadius(20)
        }
    }
}

struct ButtonsOfModes: View {
    @Binding var pressedButton: String
    var img : String
    var text: String
    
    
    var body: some View {
        let color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        HStack {
            Button {
                pressedButton = text
                
            } label: {
                Image(systemName: img)
                Text(text)
            }

        }
        .padding(6)
        .background(
            Color(color)
                .opacity(pressedButton == text ? 0.7 : 0)
        )
        .cornerRadius(10)
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SelectedButton())
    }
}

// Расширение для размеров иконок.
extension Image {
    func iconsSizes() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
    }
}
