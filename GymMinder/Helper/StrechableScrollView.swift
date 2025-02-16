//
//  StrechableScrollView.swift
//  GymMinder
//
//  Created by Serik Musaev on 14.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct StretchableScrollView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geo in
            StretchableScrollSize(
                size: geo.size,
                safeArea: geo.safeAreaInsets,
                content: content)
        }
    }
}

struct StretchableScrollSize<Content: View>: View {
    var size: CGSize
    var safeArea: EdgeInsets
    let content: () -> Content
    var headerOpacity: CGFloat {
        let fadeDistance: CGFloat = ScrollDetector.maxOffset
        let fadeOffset: CGFloat = 20
        let progress = min(max(-offset / (fadeDistance + fadeOffset), 0), 1)
        let smoothProgress = 3 * progress * progress - 2 * progress * progress * progress
        return smoothProgress
    }
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeaderView()
                    .overlay {
                        Color.black.opacity(headerOpacity * 0.6)
                        .ignoresSafeArea()
                        .offset(y: 100)
                    }
                content()
                    .zIndex(1000)
            }
            .background {
                Color.white
                ScrollDetector {
                    self.offset = -$0
                }
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        let headerHeight = size.width
        let minimumHeaderHeight = 65 + safeArea.top
        let rightOffset = offset == 0 ? 0 : offset + ScrollDetector.startingOffset
        let dynamicHeight = (headerHeight + rightOffset) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + rightOffset)
        let path = Bundle.main.path(forResource: "testTraining", ofType: "gif")!
        let gifUrl = URL(fileURLWithPath: path)
        
        GeometryReader { _ in
            WebImage(url: gifUrl, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }, placeholder: {
                Image("testTrainingStaticIm")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            })
            .frame(width: size.width, height: dynamicHeight, alignment: .top)
            .disabled(true)
            .background(Color.gray.opacity(0.1))
            // startOffset instead of 0.0
            .offset(y: -rightOffset)
        }
        .frame(height: headerHeight)
    }
}
