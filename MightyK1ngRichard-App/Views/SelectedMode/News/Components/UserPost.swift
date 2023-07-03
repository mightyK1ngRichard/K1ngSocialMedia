//
//  UserPost.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 14.06.2023.
//

import SwiftUI

struct UserPost: View {
    var username      : String
    var userAvatar    : URL?
    var imageOfPost   : URL?
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
                    if let correctLink = userAvatar {
                        AsyncImage(url: correctLink) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                                .padding(.trailing, 5)
                        }
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    
                    VStack {
                        Text(username.lowercased())
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
                
                if let correctURL = imageOfPost {
                    AsyncImage(url: correctURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width)

                    } placeholder: {
                        ProgressView()
                            .padding(.trailing, 5)
                    }
                   
                    
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
                    if let correctURL = userAvatar {
                        AsyncImage(url: correctURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            
                        } placeholder: {
                            ProgressView()
                                .padding(.trailing, 5)
                        }
                            
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
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
struct UserPost_Previews: PreviewProvider {
    static var previews: some View {        
        let userURL = URL(string: "https://w.forfun.com/fetch/6c/6cbaa4c4c22f9df35a3f194537acca00.jpeg")!
        let postURL = URL(string: "https://proprikol.ru/wp-content/uploads/2020/05/kartinki-glaza-anime-53.jpg")!
        
        GeometryReader { proxy in
            UserPost(username: "mightyK1ngRichard", userAvatar: userURL, imageOfPost: postURL, countLike: 100, countResponds: 20, location: .current, size: CGSize(width: proxy.size.width, height: 400))
        }
    }
}
