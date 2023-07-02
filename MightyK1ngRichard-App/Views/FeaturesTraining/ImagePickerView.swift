//
//  ImagePickerView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 02.07.2023.
//

import SwiftUI
import PhotosUI

struct UploadImageToServer: View {
    @State private var selectedPhotos          : [PhotosPickerItem] = []
    @State private var data                    : Data?
    @State private var showErrorSelectionImage = false
    
    var body: some View {
        VStack {
            if let data = data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                
                Text("\(data)")
                
                
            } else if showErrorSelectionImage {
                Text("Странаня ошибка с этой фоткой. Выбери другую")
            }
            Spacer()
            PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 1, matching: .images) {
                Text("Выбрать фото")
            }
            .onChange(of: selectedPhotos) { newValue in
                guard let item = selectedPhotos.first else { return }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        self.showErrorSelectionImage = false
                        if let data = data {
                            self.data = data
                        } else {
                            print("Data is nil")
                        }
                        
                    case .failure(let failure):
                        self.data = nil
                        self.showErrorSelectionImage = true
                        print("\(failure)")
                    }
                }
            }
            
        }
    }
    
}

struct UploadImageToServer_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageToServer()
    }
}

/// OLD VERSION:
/*
 @State private var showImagePicker = false
 @State private var selectedImage: Image?
 
 var body: some View {
     VStack {
         Button("select image") {
             self.showImagePicker.toggle()
             
         }
         if let img = selectedImage {
             img
                 .resizable()
                 .aspectRatio(CGSize(width: 100, height: 100), contentMode: .fill)
         }
         Button("upload image") {
             print("I am here 1")
             let uiImage = selectedImage.asUIImage()
             let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
             let imageString: String = imageData.base64EncodedString()
             print("I am here 2")
             /// Тут надо адрес сервера для upload image
             guard let url = URL(string: "http://localhost:8010/user/1/upload") else {
                 print("Invalid url")
                 return
             }
             print("I am here 3")
             let paramString = "file=\(imageString)"
             let paramData: Data = paramString.data(using: .utf8) ?? Data()
             
             var request = URLRequest(url: url)
             request.httpMethod = "POST"
             request.httpBody = paramData
             request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
             print("I am here 4")
             URLSession.shared.dataTask(with: request) { data, _, error in
                 if let error = error {
                     print(error)
                     return
                 }
                 guard let data = data else {
                     print("data is nil")
                     return
                 }
                 print("data: \(data)")
             }.resume()
             print("I am here 5")
         }
     }
     .sheet(isPresented: $showImagePicker) {
         ImagePicker(image: self.$selectedImage)
     }
 }
 */
