//
//  OffsetHelper.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 16.06.2023.
//

import SwiftUI

/// Для передачи данных при скролле.
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}


/// Отслеживаем скролл.
extension View {
    @ViewBuilder
    func offsetExtractor(coordinateSpace: String, complition: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .named(coordinateSpace))
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: complition)
                }
            }
    }
}

