//
//  FireBaseLearning.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 02.07.2023.
//

import SwiftUI

struct FireBaseLearning: View {
    @State private var buttonPressed = false
    @State private var buttonPressed2 = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Надо отменять физику")
                HStack(spacing: 1) {
                    Image(systemName: buttonPressed2 ? "heart.fill" : "heart")
                        .foregroundColor(buttonPressed2 ? .red : .black)
                        .scaleEffect(buttonPressed && buttonPressed2 ? 51.6 : 1)
                        .padding(.leading)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                buttonPressed2.toggle()
                                buttonPressed.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    buttonPressed.toggle()
                                }
                            }
                        }
                    
                }
            }
            
            Spacer()
            
            Button {
                
                // ?
            } label: {
                Text("Присоединяйтесь!")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.linearGradient(colors: [.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            }
        }
        .overlay {
            if buttonPressed && buttonPressed2 {
                Text("ЧТОООООО")
                    .font(.title)
                    .foregroundColor(.white)
            }

        }

    }
}

struct FireBaseLearning_Previews: PreviewProvider {
    static var previews: some View {
        FireBaseLearning()
    }
}

