//
//  FontView.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 12.06.2023.
//

import SwiftUI

struct FontView: View {
    var body: some View {
        VStack(spacing: 20) {
            Group {
                Text("System Font")
                    .font(.system(size: 20))
                Text("Large Title")
                    .font(.largeTitle)
                Text("Title")
                    .font(.title)
                Text("Headline")
                    .font(.headline)
                Text("Subheadline")
                    .font(.subheadline)
                Text("Body")
                    .font(.body)
                Text("Callout")
                    .font(.callout)
                Text("Caption")
                    .font(.caption)
                Text("Captio2")
                    .font(.caption2)
                Text("Footnote")
                    .font(.footnote)
            }
            
        }
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView()
    }
}
