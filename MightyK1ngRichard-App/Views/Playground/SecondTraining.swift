//
//  SecondTraining.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 18.06.2023.
//

import SwiftUI

struct UserProfile: Identifiable {
    var id: UUID
    var username: String
    var userImage: URL
    var messageText: String
}

private let urlImage = URL(string: "https://lifeo.ru/wp-content/uploads/anime-kartinka-na-rabochiy-stol-46.jpg")!

let profiles: [UserProfile] = [
    .init(id: UUID(), username: "Dmitriy 1", userImage: urlImage, messageText: "Просто тектс"),
    .init(id: UUID(), username: "Dmitriy 2", userImage: urlImage, messageText: "Просто тектс"),
    .init(id: UUID(), username: "Dmitriy 3", userImage: urlImage, messageText: "Просто тектс"),
    .init(id: UUID(), username: "Dmitriy 4", userImage: urlImage, messageText: "Просто тектс"),
    .init(id: UUID(), username: "Dmitriy 5", userImage: urlImage, messageText: "Просто тектс"),
]

struct SecondTraining: View {
    @Namespace var animation
    @State private var currentProfile: UserProfile?
    @State private var showProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(profiles) { profile in
                    VStack(spacing: 20) {
                        UserRow(user: profile)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(alignment: .center) {
                if let profile = currentProfile, showProfile {
                    ExtendedProfile(profile)
                }
            }
            
            .navigationTitle("K1ng Messager")
        }
        
    }
    
    @ViewBuilder
    private func ExtendedProfile(_ profile: UserProfile) -> some View {
        VStack {
            GeometryReader {
                let size = $0.size
                AsyncImage(url: profile.userImage) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: profile.id, in: animation)
                        .frame(width: size.width, height: size.height)
                        .clipped()

                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }

            }
            .frame(height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    private func UserRow(user: UserProfile) -> some View {
        HStack {
            AsyncImage(url: user.userImage) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .matchedGeometryEffect(id: user.id, in: animation)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 4)) {
                            self.showProfile = true
                            self.currentProfile = user
                        }
                    }
                
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            VStack {
                Text(user.username)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(user.messageText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
}

struct SecondTraining_Previews: PreviewProvider {
    static var previews: some View {
        SecondTraining()
    }
}
