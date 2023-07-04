//
//  ContentView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var selected = SelectedButton()
    @StateObject var authData = AuthDataManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthView()
                
                if selected.showMenu {
                    MenuView()
                        
                }
            }
        }
        .environmentObject(authData)
        .environmentObject(selected)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthDataManager())
            .environmentObject(SelectedButton())
            .preferredColorScheme(.dark)
    }
}
