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

private let buttons: [ModemButton] = [
    .init(text: "Фото", image: "photo"),
    .init(text: "Видео", image: "play.square"),
    .init(text: "Музыка", image: "airpodspro"),
    .init(text: "Клипы", image: "video"),
]

struct ProfileView: View {
    let userID: UInt
    
    @Environment(\.colorScheme) private var shemaColor
    @EnvironmentObject var selected   : SelectedButton
    
    @State private var pressedButton   = buttons.first!.id
    @State private var showBar         = false
    @State private var scrollProgress  : CGFloat = .zero
    @State private var scaleImage      : CGSize  = .init(width: 1, height: 1)
    @State private var user            : UserData?
    @State private var isRefresh       = false
    @State private var isServerConnect = true
    
    var body: some View {
        MainView()
            .onAppear(perform: GetNetworkData)

            /// TODO: Научиться делать refresh нормально. Пока так...
            /// Не забыть потом под UserHeader убрать overlay в MainView.
            .onChange(of: scrollProgress) { _ in
                if scrollProgress > 10 {
                    isRefresh = true
                }
                if scrollProgress == 0 && isRefresh {
                    GetNetworkData()
                    isRefresh = false
                }
            }
    }
  
    @ViewBuilder
    private func MainView() -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        GeometryReader { proxy in
            let size = proxy.size
            let safeArea = proxy.safeAreaInsets
            ZStack(alignment: .top) {
                UserHeader(size: size)
                    .ignoresSafeArea()
                    // MARK: REFRESH DATA.
                    .overlay {
                        if isRefresh {
                            ProgressView()
                                .scaleEffect(1.2)
                                .offset(y: -50)
                        }
                    }
                
                ScrollView(showsIndicators: false) {
                    MainProfileView(safeArea: safeArea, size: size)

                }
                /// Scroll reader.
                .coordinateSpace(name: MyKeys.keyOfprofileScrollView.rawValue)
                .overlay(alignment: .top) {
                    HStack {
                        Button {
                            // ?
                            self.selected.showMenu = true
                            
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
                            if let user = user {
                                Text(user.nickname)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(.primary)
                                
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray.opacity(0.2))
                                    .frame(maxWidth: .infinity, maxHeight: 5, alignment: .center)
                                    .padding(.horizontal, 30)
                            }
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
                .frame(height: UIScreen.main.bounds.size.height)
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
        
        if let user = user, let urlLink = user.backroundImage {
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
                .frame(maxWidth: .infinity, maxHeight: 230 + scrollProgress)
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
            if let user = user {
                if let url = user.userAvatar {
                    AsyncImage(url: url) { image in
                        image
                            .avatarSize(size: currentSize, backgroundColor: backgroundColor)

                    } placeholder: {
                        Circle()
                            .frame(maxWidth: currentSize <= 60 ? 60 : currentSize, maxHeight: 100)
                            .foregroundColor(Color.VK.black)
                    }
                    
                } else {
                    Image(systemName: "peson.circle")
                        .avatarSize(size: currentSize, backgroundColor: backgroundColor)
                }
                
            } else {
                Circle()
                    .frame(maxWidth: currentSize <= 60 ? 60 : currentSize, maxHeight: 100)
                    .foregroundColor(Color.VK.black)
                    .overlay {
                        if !isServerConnect {
                            VStack {
                                Image(systemName: "xmark.icloud")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 50)
                                
                                Text("Server Error")
                            }
                            .foregroundColor(.white)
                        }
                    }
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
            if let user = user, let posts = user.posts {
                ForEach(posts) { currentPost in
                    UserPostsView(post: currentPost, size: size)
                }
            }
        }
        .padding(.bottom)
    }
    
    @ViewBuilder
    private func TopView() -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        VStack {
            VStack(spacing: 5) {
                if let user = user {
                    Text(user.nickname)
                        .font(.system(.headline, weight: .black))
                        .scaleEffect(1.3)
                        .lineLimit(1)
                    
                    if let description = user.description {
                        Text(description)
                            .font(.caption)
                    }
                        
                    HStack {
                        if let locationInfo = user.locationInfo {
                            Image(systemName: "location")
                                .iconsSizes()
                            
                            Text(locationInfo)
                                .font(.caption)
                        }
                        
                        if let university = user.university {
                            Image(systemName: "graduationcap")
                                .iconsSizes()
                            
                            Text(university)
                                .font(.caption)
                        }
                        
                        Image(systemName: "info.circle")
                            .iconsSizes()
                    }
                    
                } else {
                    VStack {
                        ForEach(1...4, id: \.self) { col in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.2))
                                .frame(maxWidth: .infinity, maxHeight: 15)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .background(backgroundColor)
                                .foregroundColor(.primary)
                                .cornerRadius(20)
                        }
                    }
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
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ButtonsOfModes()
            }
            .padding(.leading)
            .padding(.top)
            
            UserImagesView()

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
    
    @ViewBuilder
    private func UserImagesView() -> some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 1) {
            UserImages()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func UserImages() -> some View {
        if let user = user, let images = user.images {
            ForEach(images.prefix(6)) {
                AsyncImage(url: $0.imageURL) { image in
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
    }
    
    /// Кнопки: фотки, видео, музыка.
    @ViewBuilder
    private func ButtonsOfModes() -> some View {
        let color = shemaColor == .dark ? Color.VK.foregroundColorButtonBlack : Color.VK.foregroundColorButtonWhite
        
        
        HStack {
            ForEach(buttons) { button in
                
                Button {
                    self.pressedButton = button.id
                    
                } label: {
                    Label(button.text, systemImage: button.image)
                        .foregroundColor(.primary)
                        .padding(6)
                        .background(
                            color
                                .opacity(pressedButton == button.id ? 0.7 : 0)
                        )
                        .cornerRadius(10)
                }
                
            }
        }
        
    }
    
    /// Количество друзей.
    @ViewBuilder
    private func CountOfFriendsView() -> some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        
        VStack {
            if let user = user {
                Text("\(user.countOfFriends) друзей")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.vertical)
                    .background(backgroundColor)
                    .foregroundColor(.primary)
                    .cornerRadius(20)
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: 15, alignment: .center)
                    .padding(.horizontal, 40)
                    .padding(.vertical)
                    .background(backgroundColor)
                    .foregroundColor(.primary)
                    .cornerRadius(20)
            }
            
        }
    }
    
    private func GetNetworkData() {
        APIManager.user.getUserById(userID: userID) { data, error in
            if let error = error {
                print(error.contentError())
                self.isServerConnect = false
                return
            }
            
            self.isServerConnect = true
            if let data = data {
                let u = data.user
                
                /// Получаем посты пользователя.
                var uPosts: [UserPostData] = []
                if let uPost = u.posts {
                    for p in uPost {
                        var tempFiles: [UserFielsData] = []
                        if let files = p.files {
                            for file in files {
                                tempFiles.append(.init(id: file.id, url: file.file_name, postID: file.post_id))
                            }
                        }
                        
                        let temp = UserPostData(id: p.id, datePublic: p.date_public, content: p.content, countOfLike: p.count_of_likes, countOfComments: p.count_of_comments, filesInPost: tempFiles, comments: [], userAvatar: p.avatar, nickname: p.nickname)
                        uPosts.append(temp)
                    }
                }
                
                /// Получаем фоторграфии пользователя.
                var uImages: [UserImagesData] = []
                if let imgs = u.images {
                    for i in imgs {
                        uImages.append(.init(id: i.id, datePublic: i.date_public, imageURL: i.image_name, countOfLikes: i.count_of_likes, countOfComments: i.count_of_comments, userID: i.user_id))
                    }
                }
                
                /// Итоговое присвоение.
                self.user = UserData(id: u.id, nickname: u.nickname, description: u.description, locationInfo: u.location, university: u.university, backroundImage: u.header_image, userAvatar: u.avatar, countOfFriends: u.count_of_friends, posts: uPosts, images: uImages)
            }
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
        
        ProfileView(userID: UInt(1))
            .environmentObject(SelectedButton())
            .preferredColorScheme(.dark)
            
    }
}

private class ModemButton: Identifiable {
    let id: UUID = .init()
    let text: String
    let image: String
    
    init(text: String, image: String) {
        self.text = text
        self.image = image
    }
}
