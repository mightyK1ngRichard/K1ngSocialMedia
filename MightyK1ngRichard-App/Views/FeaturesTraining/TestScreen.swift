//
//  TestScreen.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 24.06.2023.
//

import SwiftUI

struct TestScreen: View {
    @State private var data: UserDecoder?
    
    
    var body: some View {
        VStack {
            if let data = data {
                ForEach(data.users) { user in
                    UserCard(name: user.nickname, description: user.description, location: user.location, avatar: user.avatar)
                }
            }
        }
        .onAppear() {
            APIManager.shared.getUsers { data, error in
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    self.data = data
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
