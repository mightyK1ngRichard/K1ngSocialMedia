//
//  SelectedModeButton.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import Foundation

class SelectedButton: ObservableObject {
    @Published var selectedButton: ButtonsBar = .init(id: UUID(), text: .profile, image: "profile")
    @Published var showMenu = false
}

struct ButtonsBar: Identifiable {
    var id    : UUID
    var text  : TextModeOfButtonBar
    var image : String
}

enum TextModeOfButtonBar: String {
    case profile  = "Профиль"
    case news     = "Новости"
    case messages = "Мессенджер"
    case friends  = "Друзья"
}
