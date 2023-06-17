//
//  AnchorKey.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 17.06.2023.
//

import SwiftUI

struct AnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
