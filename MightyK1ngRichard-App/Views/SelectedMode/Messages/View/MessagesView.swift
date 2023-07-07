//
//  MessagesView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var selected: SelectedButton
    
    @State private var users: [UserData] = []
    @State private var searchedUser = ""
    @State private var errorMessage = ""
    @State private var openDialogue = false
    
    var body: some View {
        MainScreen()
            .overlay {
                if !errorMessage.isEmpty {
                    ErrorView()
                }
            }
            .refreshable {
                fetchData()
            }
    }
    
    @ViewBuilder
    private func MainScreen() -> some View {
        NavigationStack {
            VStack {
                TopView()
                ScrollView(.vertical, showsIndicators: true) {
                    SearchBar()
                    ForEach(users) { user in
                        HStack {
                            NavigationLink {
                                DialogueView()
                                    
                            } label: {
                                MessageCard(user: user)
                            }

                        }
                        .padding(.horizontal)
                        
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(Color.VK.black)
            .foregroundColor(Color.VK.white)
        .onAppear(perform: fetchData)
        }
    }
    
    private func ErrorView() -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
            
            Text(errorMessage)
                .foregroundColor(.white)
        }
    }
    
    private func TopView() -> some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .onTapGesture {
                    selected.showMenu = true
                }
            
            Text("Мессенджер")
                .font(.title2.bold())
            
            Spacer()
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    private func MessageCard(user: UserData) -> some View {
        AsyncImage(url: user.userAvatar) { img in
            img
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
        } placeholder: {
            ProgressView()
                .frame(width: 60, height: 60)
        }
        
        VStack(alignment: .leading, spacing: 10) {
            Text(user.nickname.lowercased())
                .font(.system(.headline, design: .rounded, weight: .bold))
            
            Text("Сделал щас за 5 минут то, что теперь ")
                .lineLimit(1)
                .font(.body)
        }
        .padding(.leading, 5)
    }
    
    @ViewBuilder
    private func SearchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("", text: $searchedUser)
                .placeholder(when: searchedUser.isEmpty) {
                    Text("Поиск")
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .padding(.leading)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 10)
        .padding(.bottom, 8)
        
    }

    
    // MARK: - Functions with Network:
    private func fetchData() {
        Task {
            do {
                users = try await APIManager.user.getUsers()
                
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .environmentObject(SelectedButton())
    }
}
