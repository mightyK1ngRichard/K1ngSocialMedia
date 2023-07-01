//
//  AsyncNetwork.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 01.07.2023.
//

import SwiftUI

struct AsyncNetwork: View {
    @State private var users : [UserData] = []
    
    var body: some View {
        VStack {
                ScrollView {
                    
                    HStack {
                        ForEach(users) { user in
                            VStack {
                                AsyncImage(url: user.userAvatar) { img in
                                    img
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 100)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 20)
                                        )
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.blue)
                                        }
                                    
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }
                                
                                Text(user.nickname)
                                    .font(.subheadline)
                                
                                Text(user.locationInfo ?? "")
                                    .font(.caption)
                                
                                Text(user.description ?? "")
                                    .font(.caption2)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()

                            }
                            .padding(.top, 10)
                            .frame(width: 150, height: 200)
                            .padding(.horizontal, 10)
                            .background(.mint.gradient.opacity(0.5))
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.mint)
                            }
                        }
                    }
                }
            
            
        }
        .task {
            do {
                let users = try await AsyncAPIManager.shared.GetUsers()
                var tempAllUsers: [UserData] = []
                for u in users.users {
                    
                    /// Получаем посты пользователя.
                    var userPosts: [UserPostData] = []
                    if let posts = u.posts {
                        for p in posts {
                            
                            /// Получаем файлы поста.
                            var tmpPostFiles: [UserFielsData] = []
                            if let files = p.files {
                                for f in files {
                                    let tmpFile: UserFielsData = .init(id: f.id, url: f.file_name, postID: f.post_id)
                                    tmpPostFiles.append(tmpFile)
                                }
                            }
                            
                            // TODO: Доделать комментарии, когда добавлю в апишку.
                            let commentsOfPosts: [CommentUnderPost] = []
                            //                            if let comments = p.comments {
                            //                                for c in comments {
                            //
                            //                                }
                            //                            }
                            
                            
                            let currentPost: UserPostData = .init(id: p.id, datePublic: p.date_public, content: p.content, countOfLike: p.count_of_likes, countOfComments: p.count_of_comments, filesInPost: tmpPostFiles, comments: commentsOfPosts, userAvatar: p.avatar, nickname: p.nickname)
                            
                            userPosts.append(currentPost)
                        }
                        
                    }
                    
                    /// Получаем фотографии пользователя.
                    var userImages: [UserImagesData] = []
                    if let uImgs = u.images {
                        for ui in uImgs {
                            let tmpUI: UserImagesData = .init(id: ui.id, datePublic: ui.date_public, imageURL: ui.image_name, countOfLikes: ui.count_of_likes, countOfComments: ui.count_of_comments, userID: ui.user_id)
                            userImages.append(tmpUI)
                        }
                    }
                    
                    let currentUser: UserData = .init(id: u.id, nickname: u.nickname, description: u.description, locationInfo: u.location, university: u.university, backroundImage: u.header_image, userAvatar: u.avatar, countOfFriends: u.count_of_friends, posts: userPosts, images: userImages)
                    
                    tempAllUsers.append(currentUser)
                }
                
                DispatchQueue.main.async {
                    self.users = tempAllUsers
                }
                
            } catch APIErrors.invalidURL {
                print("invalidURL")
            } catch APIErrors.invalidResponse {
                print("invalidResponse")
            } catch APIErrors.invalidData {
                print("invalidData")
            } catch {
                
            }
        }
    }

}

struct AsyncNetwork_Previews: PreviewProvider {
    static var previews: some View {
        AsyncNetwork()
    }
}


private class AsyncAPIManager {
    static let shared = AsyncAPIManager()
    private let host = "localhost"
    private let port = 8010
    
    func GetUsers() async throws -> UsersDecoder {
        let urlString = "http://\(host):\(port)/users"
        guard let url = URL(string: urlString) else {
            throw APIErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            /// Данная срочка преобразует so_text в soText.
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(UsersDecoder.self, from: data)
            
            
        } catch {
            throw APIErrors.invalidData
        }
        
    }
}

private enum APIErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
