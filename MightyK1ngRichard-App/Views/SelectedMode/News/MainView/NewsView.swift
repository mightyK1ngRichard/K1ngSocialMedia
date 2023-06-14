//
//  NewsView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct NewsView: View {
    var people = [
        "User",
    ]
    
    var body: some View {
        MainScreen()
        
    }
    
    private func MainScreen() -> some View {
        NavigationView {
            GeometryReader { proxy in
                let size = proxy.size
                ScrollView(showsIndicators: false) {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                YourCircle()
                                ForEach(0...10, id: \.self) { user in
                                    UserCircle(username: "user \(user)", userAvatar: Image("k1ng"), hasNewStory: true)
                                }
                            }
                        }
                        
                        Divider()
                        ForEach(0...10, id: \.self) { user in
                            UserPost(username: "mightyK1ngRichard", userAvatar: Image("k1ng"), imageOfPost: Image("k1ng"), countLike: 100, countResponds: 20, location: .current, size: size)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            // ?
                        } label: {
                            Image(systemName: "camera")
                                .foregroundColor(Color.primary)
                        }
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // ?
                        } label: {
                            Image(systemName: "paperplane")
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            .navigationBarTitle("Новости", displayMode: .inline)
            }
        }
    }
    
    private func YourCircle() -> some View {
        Button {
            // ?
            
        } label: {
            ZStack {
                VStack {
                    Image("k1ng")
                        .isYou(isActive: false)
                        .padding(.leading, 5)
                    
                    Text("Вы")
                        .font(.headline)
                        .foregroundColor(Color.primary)
                    
                }
                Image(systemName: "plus.circle.fill")
                    .scaleEffect(1.5)
                    .background(
                        Color.primary
                            .colorInvert()
                            .clipShape(Circle())
                    )
                    .offset(x: 30, y: 15)
            }
            
        }
        .padding(.top, 5)
        
    }
    
}

struct UserCircle: View {
    var username    : String
    var userAvatar  : Image?
    var hasNewStory : Bool = false
    
    var body: some View {
        Button {
            // ?
        } label: {
            VStack{
                if let image = userAvatar {
                    image
                        .IsActiveStory(isActive: hasNewStory)
                    
                } else {
                    Image(systemName: "person.circle")
                        .IsActiveStory(isActive: hasNewStory)
                }
                
                
                Text(username)
                    .font(.headline)
                    .foregroundColor(Color.primary)
            }
            .frame(maxWidth: 80)
        }
        .padding(.top, 5)
        .padding(.leading, 5)
        
    }
}

struct UserPost: View {
    var username      : String
    var userAvatar    : Image?
    var imageOfPost   : Image?
    var countLike     : Int
    var countResponds : Int
    var location      : Locale?
    let size          : CGSize
    
    @State private var pressedLike    = false
    @State private var pressedComment = false
    @State private var pressedSend    = false
    @State private var inputRespond   = ""
    
    var body: some View {
            VStack {
                HStack {
                    if let img = userAvatar {
                        img
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    
                    VStack {
                        Text(username)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Moscow")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        // ?
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                    }

                }
                .padding(.horizontal)
                
                if let imgPost = imageOfPost {
                    imgPost
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width)
                        .frame(maxWidth: .infinity)
                        .background(Color(backgroundColor))
                }
                
                HStack {
                    HStack(spacing: 20) {
                        Group {
                            Button {
                                // ?
                                self.pressedLike.toggle()
                                
                            } label: {
                                Image(systemName: pressedLike ? "heart.fill" : "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23)
                                    .foregroundColor(pressedLike ? .red : .primary)
                            }
                            
                            Button {
                                // ?
                            } label: {
                                Image(systemName: "message")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23)
                                    .foregroundColor(.primary)
                            }
                            
                            
                            Button {
                                // ?
                            } label: {
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23)
                                    .foregroundColor(.primary)
                                
                            }
                        }
                    }
                    .padding(.top, 5)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                
                Button {
                    // ?
                } label: {
                    Text("Смотреть комментарии (\(countResponds))")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .foregroundColor(.gray)
                }

                
                HStack {
                    if let img = userAvatar {
                        img
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white.opacity(0.5))
                    }

                    TextField(text: $inputRespond) {
                        Text("Добавьте комментарий...")
                            .font(.caption)
                    }
                    
                    Spacer()
                }
                .padding(.leading)
                
                Text("\(5) часов назад")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
            .padding(.bottom)

    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

/// Расширение для рамочки кружка.
extension Image {
    func IsActiveStory(isActive: Bool) -> some View {
        let color1 = #colorLiteral(red: 1, green: 0, blue: 0.845524013, alpha: 1)
        let color2 = #colorLiteral(red: 1, green: 0.4512313604, blue: 0.3125490546, alpha: 1)
        let color3 = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        let gradient = LinearGradient(colors: [
            Color(color1),
            Color(color2),
            Color(color3)
        ], startPoint: .leading, endPoint: .bottom)
        
        return self
            .resizable()
            .frame(width: 73, height: 73)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .padding(3)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .fill(isActive ? gradient : LinearGradient(colors: [Color.gray.opacity(0.7)], startPoint: .leading, endPoint: .top))
            }
        
    }
    
    func isYou(isActive: Bool) -> some View {
        let color1 = #colorLiteral(red: 1, green: 0, blue: 0.845524013, alpha: 1)
        let color2 = #colorLiteral(red: 1, green: 0.4512313604, blue: 0.3125490546, alpha: 1)
        let color3 = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        let gradient = LinearGradient(colors: [
            Color(color1),
            Color(color2),
            Color(color3)
        ], startPoint: .leading, endPoint: .bottom)
        
        if isActive {
            return AnyView(
                self
                    .resizable()
                    .frame(width: 73, height: 73)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(3)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(isActive ? gradient : LinearGradient(colors: [Color.gray.opacity(0.7)], startPoint: .leading, endPoint: .top))
                    }
            )
        }
        return AnyView(
            self
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        )
    }
}
