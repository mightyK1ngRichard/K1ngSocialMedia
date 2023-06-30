//
//  TestScreen.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 24.06.2023.
//

import SwiftUI

struct TestScreen: View {
    @State private var data: UsersDecoder?
    
    
    var body: some View {
        VStack {
           
        }
        .onAppear() {
            APIManager.user.post.getUserPost(userID: 1) { data, error in
                if let error = error {
                    print("ERROR: ", error)
                    return
                }
                if let data = data {
                    for el in data.posts {
                        print(el.content)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func UserCard(name: String, description: String?, location: String?, avatar: URL?) -> some View {
        VStack {
            AsyncImage(url: avatar) { img in
                img
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }

        }
    }
}

struct TestScreen_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
    }
}
