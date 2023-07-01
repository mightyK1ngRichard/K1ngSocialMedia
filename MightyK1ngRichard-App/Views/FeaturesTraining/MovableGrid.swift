//
//  MovableGrid.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 01.07.2023.
//

import SwiftUI

struct MovableGrid: View {
    @State private var colors: [Color] = [.black, .brown, .pink, .purple, .orange, .red, .green, .yellow, .indigo, .blue, .mint, .cyan]
    @State private var draggingItem: Color?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                let colomns = Array(repeating: GridItem(spacing: 10), count: 3)
                LazyVGrid(columns: colomns) {
                    ForEach(colors, id: \.self) { color in
                        GeometryReader {
                            let size = $0.size
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient)
                                .draggable(color) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: size.width, height: size.height)
                                        .onAppear {
                                            self.draggingItem = color
                                        }
                                }
                                .dropDestination(for: Color.self) { items, location in
                                    draggingItem = nil
                                    return false
                                } isTargeted: { status in
                                    if let draggingItem, status, draggingItem != color, let sourceIndex = colors.firstIndex(of: draggingItem), let destinationIndex = colors.firstIndex(of: color) {
                                        withAnimation() {
                                            let sourceItem = colors.remove(at: sourceIndex)
                                            colors.insert(sourceItem, at: destinationIndex)
                                        }
                                    }
                                    
                                }
                        }
                        
                    }
                    .frame(height: 100)
                    //                        .background(.red)
                }
                
            }
            .padding(15)
            
            .navigationTitle("Movable Grid")
        }
    }
}


struct MovableGrid_Previews: PreviewProvider {
    static var previews: some View {
        MovableGrid()
    }
}
