//
//  AuthView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 03.07.2023.
//

import SwiftUI

struct AuthView: View {
    
    var body: some View {
        SignUpView()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(DataManager())
    }
}
