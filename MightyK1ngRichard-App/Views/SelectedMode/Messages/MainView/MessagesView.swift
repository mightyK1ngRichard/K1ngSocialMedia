//
//  MessagesView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var selected: SelectedButton
    
    var body: some View {
        //
        Text("")
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .environmentObject(SelectedButton())
    }
}
