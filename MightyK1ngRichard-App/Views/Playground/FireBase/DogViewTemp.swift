//
//  DogsViewTemp.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 03.07.2023.
//


 import SwiftUI
 import Firebase

 struct DogsViewTemp: View {
     @StateObject var dataManager       = DataManager()
     @EnvironmentObject var selected    : SelectedButton
     
     @State private var showAddDogView = false
     @State private var dogBreed = ""
     
     var body: some View {
         NavigationView {
             List(dataManager.dogs, id: \.id) { dog in
                 Text(dog.breed)
             }
             
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button {
                         self.showAddDogView = true
                         
                     } label: {
                         Image(systemName: "plus")
                             .foregroundColor(.primary)
                             .scaleEffect(1.2)
                     }
                 }
                 
                 ToolbarItem(placement: .navigationBarLeading) {
                     Button {
                         // ?
                         selected.showMenu = true
                     } label: {
                         Image(systemName: "chevron.backward")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .scaleEffect(1.2)
                             .foregroundColor(.primary)
                     }

                 }
             }
             
             .navigationTitle("Dogs")
         }
         .sheet(isPresented: $showAddDogView) {
             AddDogView()
         }
         .environmentObject(dataManager)
     }
     
     @ViewBuilder
     private func AddDogView() -> some View {
         TextField("Порода собаки", text: $dogBreed)
             .padding(.horizontal)
             .padding(.vertical, 5)
             .background(.gray.opacity(0.3))
             .cornerRadius(10)
             .padding(.horizontal)
         
         Button("save") {
             dataManager.AddDog(dogBreed: dogBreed)
             showAddDogView = false
         }
     }
 }

 struct DogsViewTemp_Previews: PreviewProvider {
     static var previews: some View {
         DogsViewTemp()
             .environmentObject(DataManager())
     }
 }

