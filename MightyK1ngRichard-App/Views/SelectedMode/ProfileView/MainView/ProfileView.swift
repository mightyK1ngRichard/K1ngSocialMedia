//
//  ProfileView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var selected: SelectedButton

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
    var backgroundColor : UIColor = #colorLiteral(red: 0.1105830893, green: 0.1105830893, blue: 0.1105830893, alpha: 1)
    var colorOfText     : Color = .white
    var countOfFriends  = "105" + "дрезей"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    Image("wwdc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack {
                        ZStack(alignment: .top) {
                            Color(.black)
                                .offset(y: 20)
                            
                            TopView()
                            
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
                        Spacer()
                    }
                    .padding(.top, 150)
                }
                
                DownView()

            }
        }
        .background(Color(.black))
        .ignoresSafeArea()
    }
    
    private func TopView() -> some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 3) {
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
            .foregroundColor(colorOfText)
            .frame(maxWidth: .infinity, maxHeight: 200)
            
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
            
            HStack {
                
            }
        }
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
