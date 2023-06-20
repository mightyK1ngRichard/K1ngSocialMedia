//
//  UserPosts.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 17.06.2023.
//

import SwiftUI

/// View постов.
struct UserPostsView: View {
    @Environment(\.colorScheme) private var shemaColor
    @State private var pressedLike    = false
    @State private var pressedComment = false
    @Binding var scrollProgress       : CGFloat
    
    var textOfPost  : String?
    var imageOfPost : URL?
    var dateOfPost  : Date
    var username    : String
    var userAvatar  : URL?
    var countOfLike : Int
    var size        : CGSize
    
    var body: some View {
        let backgroundColor: Color = self.shemaColor == .dark ? Color.VK.black : Color.VK.white
        
        VStack {
            Group {
                HStack {
                    /// Аватарка пользователя.
                    if let urlLink = userAvatar {
                        AsyncImage(url: urlLink) { image in
                            image
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                            
                        } placeholder: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(.trailing, 5)
                                .foregroundColor(.primary)
                        }
                        
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.primary)
                    }
                    
                    VStack {
                        Text(username)
                            .font(.subheadline)
                            .foregroundColor(.primary)
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
                            .foregroundColor(.primary)
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
                        .background(backgroundColor)
                    
                } placeholder: {
                    ProgressView()
                        .padding(.trailing, 5)
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
        .background(backgroundColor)
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
            .foregroundColor(.primary.opacity(0.6))
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
        .foregroundColor(.primary.opacity(0.6))
    }
    
}

struct UserPosts_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
