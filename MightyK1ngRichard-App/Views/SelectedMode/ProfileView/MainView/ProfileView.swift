//
//  ProfileView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 14.06.2023.
//

import SwiftUI

extension Color {
    struct VK {
        static var black: Color {
            let color = #colorLiteral(red: 0.1105830893, green: 0.1105830893, blue: 0.1105830893, alpha: 1)
            return Color(color)
        }
        
        static var white: Color {
            let color = #colorLiteral(red: 0.8116301894, green: 0.8139874935, blue: 0.8704192042, alpha: 1)
            return Color(color)
        }
        
        static var foregroundColorButtonWhite: Color {
            let color = #colorLiteral(red: 0.5854681134, green: 0.556910038, blue: 0.9186736941, alpha: 0.3264693709)
            return Color(color)
        }
        
        static var foregroundColorButtonBlack: Color {
            let color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return Color(color)
        }
    }
}

struct ProfileView: View {
    @Environment(\.colorScheme) private var shemaColor
    @EnvironmentObject var selected   : SelectedButton
    
    @State private var pressedButton  = "Фото"
    @State private var showBar        = false
    @State private var scrollProgress : CGFloat = .zero
    @State private var scaleImage     : CGSize  = .init(width: 1, height: 1)
    
    var userPosts       = [
        ("2023-02-02", "Просто что-то про жизнь"),
        ("2023-02-02", "Просто что-то про жизнь"),
        ("2023-02-02", "Просто что-то про жизнь"),
        ("2023-02-02", "Просто что-то про жизнь")
    ]
    var nickname        = "Dmitriy Permyakov"
    var description     = " Engoing Web/iOS developing"
    var locationInfo    = "London"
    var backroundImage  : URL?
    var userAvatar      : URL?
    var countOfFriends  = "105" + " друзей"
    
    var body: some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        
        GeometryReader { proxy in
            let size = proxy.size
            let safeArea = proxy.safeAreaInsets
            ZStack(alignment: .top) {
                UserHeader(size: size)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    MainProfileView(safeArea: safeArea, size: size)
                }
                /// Scroll reader.
                .coordinateSpace(name: MyKeys.keyOfprofileScrollView.rawValue)
                .overlay(alignment: .top) {
                    HStack {
                        Button {
                            // ?
                            selected.showMenu = true
                            
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(
                                    Circle()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(backgroundColor.opacity(0.8))
                                        .offset(x: 2)
                                )
                                .foregroundColor(.white)
                                .frame(height: 20)
                        }
                        
                        
                        Spacer()
                        if showBar {
                            Text(nickname)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.primary)
                        }
                        
                        Button {
                            // ?
                            
                        } label: {
                            Image(systemName: "square.grid.2x2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(
                                    Circle()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(backgroundColor.opacity(0.8))
                                )
                                .foregroundColor(.white)
                                .frame(height: 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, safeArea.top)
                    .padding(.bottom)
                    .background(showBar ? backgroundColor : Color.clear)
                }
                .ignoresSafeArea()
            }
        }
    }
    
    private func MainProfileView(safeArea: EdgeInsets, size: CGSize) -> some View {
        ZStack(alignment: .top) {

            RoundedRectangle(cornerRadius: 20)
                .fill(shemaColor == .dark ? .black : .white)
                .padding(.top, safeArea.top + 130)
            
            VStack {
                TopView()
                CountOfFriendsView()
                imagesView()
                PostsView(size: size)
            }
            .padding(.top, safeArea.top + 130)
            
            UserAvatar(safeArea: safeArea)
        }
    }
    
    @ViewBuilder
    private func UserHeader(size: CGSize) -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        if let urlLink = backroundImage {
            AsyncImage(url: urlLink) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width)
                    .scaleEffect(scaleImage)
                
            } placeholder: {
                Rectangle()
                    .fill(backgroundColor)
                    .frame(maxWidth: .infinity)
            }
            
        } else {
            Rectangle()
                .fill(backgroundColor)
                .frame(maxWidth: .infinity)
        }
        
    }
    
    @ViewBuilder
    private func UserAvatar(safeArea: EdgeInsets) -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        let isReduceAvatar = scrollProgress < 0
        let currentSize = isReduceAvatar ? 100 + scrollProgress : 100
        
        Button {
            // ?
         
            
        } label: {
            if let url = userAvatar {
                AsyncImage(url: url) { image in
                    image
                        .avatarSize(size: currentSize, backgroundColor: backgroundColor)

                } placeholder: {
                    Image(systemName: "person.circle")
                        .avatarSize(size: currentSize, backgroundColor: backgroundColor)

                        .foregroundColor(.primary)
                }
                
            } else {
                Image(systemName: "peson.circle")
                    .avatarSize(size: currentSize, backgroundColor: backgroundColor)

            }
        }
        .padding(.top, safeArea.top + 78)
        .offsetExtractor(coordinateSpace: MyKeys.keyOfprofileScrollView.rawValue) { scrollRect in
            scrollProgress = scrollRect.minY
        }
        .onChange(of: scrollProgress) { _ in
            showBar = (-scrollProgress >= 130 - 35)
            let scale = max(1, 1 + scrollProgress / 40)
            scaleImage = scrollProgress > 0 ? CGSize(width: scale, height: scale) : CGSize(width: 1, height: 1)
        }
    }
    
    @ViewBuilder
    private func PostsView(size: CGSize) -> some View {
        VStack {
            // TODO: При работе с БД заменить данные
            ForEach(0...4, id: \.self) { _ in
                let test = """
Пишу что-то для тест поста. Я хз что писать для проверки вёрстки, но надо побольше текста.
Так, вот я сделал абзац.

А вот теперь ещё один.
""".trimmingCharacters(in: .whitespaces)
                let imageOfPost = URL(string: "https://img1.akspic.ru/attachments/crops/7/1/6/8/6/168617/168617-wwdc22-grafika-art-gaz-vizualnyj_effekt_osveshheniya-1366x768.jpg")!
                UserPostsView(scrollProgress: $scrollProgress, textOfPost: test, imageOfPost: imageOfPost, dateOfPost: .now, username: nickname, userAvatar: userAvatar, countOfLike: 10, size: size)
            }
        }
    }
    
    @ViewBuilder
    private func TopView() -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
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
                    
                    Image(systemName: "graduationcap")
                        .iconsSizes()
                    
                    Text("МГТУ им. Н.Э.Баумана")
                        .font(.caption)
                    
                    Image(systemName: "info.circle")
                        .iconsSizes()
                }
            }
            .padding()
            .padding(.top, 40)
            .foregroundColor(.primary)
            
            Button {
                // ?
                
            } label: {
                Text("Подписаться")
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .padding(.vertical, 5)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            .padding(.horizontal, 20)
            .padding(.bottom)
        }
        .foregroundColor(.primary)
        .frame(height: 200)
        .background(backgroundColor)
        .cornerRadius(20)
    }
    
    @ViewBuilder
    private func imagesView() -> some View {
        let buttons = [
            ("Фото", "photo"),
            ("Видео", "play.square"),
            ("Музыка", "airpodspro"),
            ("Клипы", "video"),
        ]
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        
        VStack {
            // TODO: Сделать LazyHStack. Щас лень.
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(buttons, id: \.self.0) {
                        ButtonsOfModes(img: $0.1, text: $0.0)
                    }
                }
            }
            .padding(.leading)
            .padding(.top)
            
            HStack {
                let temp = URL(string: "https://sm.ign.com/t/ign_in/screenshot/default/across-the-spider-verse_5k3c.1200.jpg")!
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(0...2, id: \.self) { _ in
                        AsyncImage(url: temp) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.width / 3 - 10)
                                .clipped()
                            
                        } placeholder: {
                            ProgressView()
                                .frame(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.width / 3 - 10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            /// Кнопки загрузить фото и смотреть ещё.
            HStack(spacing: 25) {
                Button {
                    // ?
                    
                } label: {
                    Image(systemName: "plus")
                    Text("Загрузить фото")
                }
                .foregroundColor(.primary)
                
                Divider()
                    .background(Color.primary.opacity(0.6))
                    .frame(height: 15)
                
                Button {
                    // ?
                    
                } label: {
                    Text("Смотреть ещё")
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                }
                .foregroundColor(.primary)
            }
            .padding(.bottom)
        }
        .foregroundColor(.white)
        .background(backgroundColor)
        .cornerRadius(20)
    }
    
    /// Кнопки: фотки, видео, музыка.
    @ViewBuilder
    private func ButtonsOfModes(img: String, text: String) -> some View {
        let color = shemaColor == .dark ? Color.VK.foregroundColorButtonBlack : Color.VK.foregroundColorButtonWhite

        HStack {
            Button {
                pressedButton = text
                
            } label: {
                Label(text, systemImage: img)
                    .foregroundColor(pressedButton == text ? Color.black : .primary)
            }
            
        }
        .padding(6)
        .background(
            color
                .opacity(pressedButton == text ? 0.7 : 0)
        )
        .cornerRadius(10)
    }
    
    /// Количество друзей.
    @ViewBuilder
    private func CountOfFriendsView() -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        
        VStack {
            Text(countOfFriends)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.vertical)
                .background(backgroundColor)
                .foregroundColor(.primary)
                .cornerRadius(20)
        }
    }
}

/// Расширение для размеров иконок.
extension Image {
    func iconsSizes() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
    }
    
    func avatarSize(size: Double, backgroundColor: Color) -> some View {
        return self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: size <= 60 ? 60 : size, maxHeight: 100)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundColor(backgroundColor)
            }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let backImg = URL(string: "https://d1lss44hh2trtw.cloudfront.net/assets/article/2023/01/09/apple-to-unveil-mixed-reality-headset-spring-2023-news_feature.jpg")!
        let userURL = URL(string: "https://ru-static.z-dn.net/files/df9/899fd190739b0985daa1921650cb9897.jpg")!
        
        ProfileView(backroundImage: backImg, userAvatar: userURL)
            .environmentObject(SelectedButton())
    }
}
