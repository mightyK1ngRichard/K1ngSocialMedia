//
//  FirebaseService.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 03.07.2023.
//

import Foundation
import Firebase

 class DataManager: ObservableObject {
     @Published var dogs: [Dog] = []
     
     init() {
         FetchDogs()
     }
     
     func FetchDogs() {
         dogs.removeAll()
         let db = Firestore.firestore()
         let ref = db.collection("Dogs")
         ref.getDocuments { snapshot, error in
             if let error = error {
                 print("==> ERROR FROM FetchDogs: \(error.localizedDescription)")
                 return
             }
             
             if let snapshot = snapshot {
                 for document in snapshot.documents {
                     let data = document.data()
                     let id = data["id"] as? Int ?? 0
                     let breed = data["breed"] as? String ?? ""
                     
                     let dog = Dog(id: id, breed: breed)
                     self.dogs.append(dog)
                 }
             }
         }
     }
     
     func AddDog(dogBreed: String) {
         let db = Firestore.firestore()
         let ref = db.collection("Dogs").document(dogBreed)
         ref.setData(["breed": dogBreed, "id": 6]) { error in
             if let error = error {
                 print("==> ERROR FROM AddDog: \(error.localizedDescription)")
                 return
             }
         }
     }
     
 }

 struct Dog {
     let id    : Int
     let breed : String
 }
