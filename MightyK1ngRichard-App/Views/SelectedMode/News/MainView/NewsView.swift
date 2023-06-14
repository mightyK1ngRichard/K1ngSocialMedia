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
    
    private func YourCircle() -> some View {
        Button {
            // ?
            
        } label: {
            ZStack {
                VStack {
                    Image("k1ng")
                        .IsActiveStory(isActive: false)
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
        
        if isActive {
            return AnyView(
                self
                    .resizable()
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(4)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 3)
                            .fill(gradient)
                    })
        }
        return AnyView(self
            .resizable()
            .frame(width: 80, height: 80)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
        )
    }
}
