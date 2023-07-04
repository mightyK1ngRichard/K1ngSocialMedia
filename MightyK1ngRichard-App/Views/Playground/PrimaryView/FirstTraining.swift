//
//  FirstTraining.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 16.06.2023.
//

import SwiftUI

struct FirstTraining: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            PersoneViewTrain(size: size, safeArea: safeArea)
                .ignoresSafeArea()
        }
        .background(.white)
    }
}

struct PersoneViewTrain: View {
    @Environment(\.colorScheme) private var colorSheme
    @EnvironmentObject var selected: SelectedButton
    
    @State private var scrollProgress   : CGFloat = 0
    @State private var textHeaderOffset : CGFloat = 0
    
    var size     : CGSize
    var safeArea : EdgeInsets
    
    var body: some View {
        let isHavingNotch = safeArea.top != 0
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                Image("k1ng")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130 - (75 * scrollProgress), height: 130 - (75 * scrollProgress))
                    .opacity(1 - scrollProgress)
                    .blur(radius: scrollProgress * 10, opaque: true)
                    .clipShape(Circle())
                    .anchorPreference(key: AnchorKey.self, value: .bounds, transform: {
                        return [MyKeys.keyOfAnchor.rawValue: $0]
                    })
                    .padding(.top, safeArea.top + 15)
                    .offsetExtractor(coordinateSpace: MyKeys.keyOfScrollView.rawValue) { scrollRect in
                        guard isHavingNotch else { return }
                        let progress = -scrollRect.minY / 25
                        scrollProgress = min(max(progress, 0), 1)
                    }
                
                let fixedTopHeader: CGFloat = safeArea.top
                Text("mightyK1ngRichard")
                    .font(.system(.caption, weight: .bold))
                    .padding(.bottom)
                    .foregroundColor(.black)
                    .background() {
                        Rectangle()
                            .fill(colorSheme == .dark ? .white : .white)
                            .frame(width: size.width)
                            .padding(.top, textHeaderOffset < fixedTopHeader ? -safeArea.top : 0)
                            .shadow (color: .black.opacity(textHeaderOffset < fixedTopHeader ? 0.1
                            : 0) , radius: 5, x: 0, y: 5)
                    }
                    .offset(y: textHeaderOffset < fixedTopHeader ? -(textHeaderOffset - fixedTopHeader) : 0)
                    .offsetExtractor(coordinateSpace: MyKeys.keyOfScrollView.rawValue) {
                        textHeaderOffset = $0.minY
                    }
                    .zIndex(1)
                
                ExampleRows()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .backgroundPreferenceValue(AnchorKey.self) { pref in
            GeometryReader { proxy in
                if let anchor = pref[MyKeys.keyOfAnchor.rawValue], isHavingNotch {
                    let frameGect = proxy[anchor]
                    let isHavingDynamicIsland = safeArea.top > 51
                    let capsuleHeight = isHavingDynamicIsland ? 37 : (safeArea.top - 15)
                    /// Капсула.
                    Canvas { out, size in
                        out.addFilter(.alphaThreshold(min: 0.5))
                        out.addFilter(.blur(radius: 12))
                        out.drawLayer { ctx in
                            if let headerView = out.resolveSymbol(id: 0) {
                                ctx.draw(headerView, in: frameGect)
                            }
                            if let dynamicIsland = out.resolveSymbol(id: 1) {
                                let rect = CGRect(x: (size.width - 120) / 2, y: isHavingDynamicIsland ? 11 : 0, width: 120, height: capsuleHeight)
                                ctx.draw(dynamicIsland, in: rect)
                            }
                        }
                        
                    } symbols: {
                        HeaderView(frameGect)
                            .tag(0)
                            .id(0)
                        
                        DynamicIslandCapsule(capsuleHeight)
                            .tag(1)
                            .id(1)
                    }

                }
            }
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(colorSheme == .dark ? .white : .white)
                    .frame(height: 15)
            }
        }
        .overlay(alignment: .top) {
            HStack {
                Button {
                    // ?
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
                        selected.showMenu = true
                    }
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }
                
                Spacer()
                
                Button {
                    // ?
                    
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }
            }
            .padding(.horizontal)
            .padding(.top, safeArea.top)
        }
        .coordinateSpace(name: MyKeys.keyOfScrollView.rawValue)
    }
    
    
    @ViewBuilder
    private func HeaderView(_ frameGect: CGRect) -> some View {
        Circle()
            .frame(width: frameGect.width, height: frameGect.height)
    }
    
    @ViewBuilder
    private func DynamicIslandCapsule(_ height: CGFloat = 37) -> some View {
        Capsule()
            .fill(.black)
            .frame(maxWidth: 120, maxHeight: height)
    }
    
    @ViewBuilder
    private func ExampleRows() -> some View {
        VStack {
            ForEach(0...20, id: \.self) { _ in
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.gray.opacity(0.15))
                        .frame(height: 25)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.gray.opacity(0.15))
                        .frame(height: 15)
                        .padding(.trailing, 25)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.gray.opacity(0.15))
                        .padding(.trailing, 150)
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.bottom, safeArea.bottom)
    }
}

struct FirstTraining_Previews: PreviewProvider {
    static var previews: some View {
        FirstTraining()
    }
}
