//
//  ProfileView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 14.06.2023.
//

import SwiftUI

var colorOfText     : Color = .white
var backgroundColor : UIColor = #colorLiteral(red: 0.1105830893, green: 0.1105830893, blue: 0.1105830893, alpha: 1)

struct ProfileView: View {
    @EnvironmentObject var selected  : SelectedButton
    @State private var pressedButton = "Фото"
    
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
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                ScreenOfUser(size: proxy.size)
                
            }
        }
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
    func ScreenOfUser(size: CGSize) -> some View {
        ZStack(alignment: .top) {
            if let urlLink = backroundImage {
                AsyncImage(url: urlLink) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width)
                    
                } placeholder: {
                    ProgressView()
                }
                
            } else {
                Image("k1ng")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width)
            }
            
            VStack {
                ZStack(alignment: .top) {
                    Color.black
                        .offset(y: 20)
                    
                    VStack {
                        TopView()
                            .frame(height: 200)
                        CountOfFriendsView()
                        
                        imagesView()
                        
                        // TODO: При работе с БД заменить данные
                        ForEach(0...4, id: \.self) { _ in
                            let test = """
Пишу что-то для тест поста. Я хз что писать для проверки вёрстки, но надо побольше текста.
Так, вот я сделал абзац.

А вот теперь ещё один.
""".trimmingCharacters(in: .whitespaces)
                            let imageOfPost = URL(string: "https://get.wallhere.com/photo/anime-girl-hurt-tennis-racquet-courts-1100259.jpg")!
                            UserPostsView(textOfPost: test, imageOfPost: imageOfPost, dateOfPost: .now, username: nickname, userAvatar: userAvatar, countOfLike: 10, size: size)
                        }
                    }
                    
                    Button {
                        // ?
                        self.selected.showMenu = true
                        
                    } label: {
                        if let url = userAvatar {
                            AsyncImage(url: url) { image in
                                image
                                    .avatarSize()
                                    .onTapGesture {
                                        DispatchQueue.main.async {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
                                                selected.showMenu = true
                                            }
                                        }
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            
                        } else {
                            Image("k1ng")
                                .avatarSize()
                        }
                    }
                }
            }
            .padding(.top, 180)
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
                        ButtonsOfModes(img: $0.1, text: $0.0)
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
            
            /// Кнопки загрузить фото и смотреть ещё.
            HStack(spacing: 25) {
                Button {
                    // ?
                    
                } label: {
                    Image(systemName: "plus")
                    Text("Загрузить фото")
                }
                
                Divider()
                    .background(Color.white.opacity(0.6))
                
                Button {
                    // ?
                    
                } label: {
                    Text("Смотреть ещё")
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.bottom)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 220)
        .background(Color(backgroundColor))
        .cornerRadius(20)
    }
    
    /// Кнопки: фотки, видео, музыка.
    @ViewBuilder
    private func ButtonsOfModes(img: String, text: String) -> some View {
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
    
    /// Количество друзей.
    private func CountOfFriendsView() -> some View {
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

/// View постов.
struct UserPostsView: View {
    @State private var pressedLike    = false
    @State private var pressedComment = false
    
    var textOfPost  : String?
    var imageOfPost : URL?
    var dateOfPost  : Date
    var username    : String
    var userAvatar  : URL?
    var countOfLike : Int
    var size        : CGSize
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    if let urlLink = userAvatar {
                        AsyncImage(url: urlLink) { image in
                            image
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    
                    VStack {
                        Text(username)
                            .font(.subheadline)
                            .foregroundColor(colorOfText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(dateOfPost.formatted())")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                }
                
                if let text = textOfPost {
                    HStack {
                        Text(text)
                            .foregroundColor(colorOfText)
                            .font(.body)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            if let urlLink = imageOfPost {
                AsyncImage(url: urlLink) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width)
                        .background(Color(backgroundColor))
                    
                } placeholder: {
                    ProgressView()
                }
                
            }

            HStack {
                Button {
                    
                    self.pressedLike.toggle()
                    
                } label: {
                    LikeButtonView(isPressed: pressedLike)
                }
                
                Button {
                    // ? Окрыть view для коммента.
                    self.pressedComment.toggle()
                    
                } label: {
                    CommentButtonView()
                }
                
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .background(Color(backgroundColor))
        .cornerRadius(20)
    }
    
    @ViewBuilder
    private func LikeButtonView(isPressed: Bool) -> some View {
        if isPressed {
            HStack {
                Image(systemName: "heart.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(.red)
                    .background(Color.white.frame(width: 12, height: 12))
                    .clipShape(Circle())
                
                Text("\(pressedLike ? countOfLike + 1 : countOfLike)")
                    .font(.caption)
                    .offset(x: -4)
                    .foregroundColor(.red)
            }
            .padding(.horizontal, 7)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .foregroundColor(.red)
                    .opacity(0.15)
            )
            
        } else {
            HStack {
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                
                
                Text("\(countOfLike)")
                    .font(.caption)
                    .offset(x: -4)
            }
            .padding(.horizontal, 7)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .foregroundColor(.gray)
                    .opacity(0.1)
            )
            .foregroundColor(.white.opacity(0.6))
        }
    }
    
    @ViewBuilder
    private func CommentButtonView() -> some View {
        HStack {
            Image(systemName: "bubble.left")
            
            Text("3")
                .font(.caption)
                .offset(x: -5)
        }
        .padding(.leading, 7)
        .padding(.trailing, 4)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .foregroundColor(.gray)
                .opacity(0.1)
        )
        .foregroundColor(.white.opacity(0.6))
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let backImg = URL(string: "https://w-dog.ru/wallpapers/16/9/442689553177276/anime-iskusstvo-mahou-shoujo-madoka-magika-kaname-madoka-devushka-sidit-vzglyad-volshebnica-derevo-tron.jpg")!
        
        let userURL = URL(string: "https://proprikol.ru/wp-content/uploads/2020/05/kartinki-glaza-anime-53.jpg")!
        
        ProfileView(backroundImage: backImg, userAvatar: userURL)
            .environmentObject(SelectedButton())
        
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
    
    func avatarSize() -> some View {
        return self
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
    }
    
}
