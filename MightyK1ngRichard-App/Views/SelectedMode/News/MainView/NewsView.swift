//
//  NewsView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var selectedMode: SelectedButton
    
    var people = [
        "developer",
        "mightyK1ngRichard",
        "k1ng",
        "richard",
        "User 2",
        "User 3",
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
                                ForEach(people, id: \.self) { user in
                                    UserCircle(username: user, userAvatar: Image("k1ng"), hasNewStory: true)
                                }
                            }
                        }
                        
                        Divider()
                        ForEach(0...10, id: \.self) { user in
                            // TODO: Заменить при api.
                            let userURL = URL(string: "https://ru-static.z-dn.net/files/df9/899fd190739b0985daa1921650cb9897.jpg")!
                            let postURL = URL(string: "https://hi-news.ru/wp-content/uploads/2015/06/WWDC-2015-Wallpaper-for-Estandar-Resolution-Mac-Black-Edition-2880-x-18001.png")!
                            
                            UserPost(username: "mightyK1ngRichard", userAvatar: userURL, imageOfPost: postURL, countLike: 100, countResponds: 20, location: .current, size: size)
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
        .onAppear() {
            // ?
        }
    }
    
    private func YourCircle() -> some View {
        Button {
            // ?
            DispatchQueue.main.async {
                self.selectedMode.showMenu = true
                self.selectedMode.selectedButton.text = .news
            }
            
        } label: {
            ZStack {
                VStack {
                    Image("k1ng")
                        .isYou(isActive: false)
                        .padding(.leading, 5)
                    
                    Text("Вы")
                        .font(.footnote)
                        .foregroundColor(Color.primary)
                    
                }
                Image(systemName: "plus.circle.fill")
                    .scaleEffect(1.2)
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
                    .font(.footnote)
                    .foregroundColor(Color.primary)
            }
            .frame(maxWidth: 80)
        }
        .padding(.top, 5)
        .padding(.leading, 5)
        
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(SelectedButton())
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
        let color2 = #colorLiteral(red: 0.9162911177, green: 0.3988925815, blue: 0.2392087281, alpha: 1)
        let color3 = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        let gradient = LinearGradient(colors: [
            Color(color3),
            Color(color1),
            Color(color2),
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
