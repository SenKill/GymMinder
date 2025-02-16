//
//  ScrollDetector.swift
//  GymMinder
//
//  Created by Serik Musaev on 15.02.2025.
//

import UIKit
import SwiftUI

/// To get scroll offset from UIScrollView
struct ScrollDetector: UIViewRepresentable {
    static var maxOffset: CGFloat = 0
    static var startingOffset: CGFloat = 0
    var onScroll: (CGFloat) -> ()
    
    private func getScrollView(from uiView: UIView) -> UIScrollView? {
        if let scrollView = uiView as? UIScrollView {
            return scrollView
        } else if uiView.superview == nil {
            return nil
        }
        return getScrollView(from: uiView.superview!)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            /// Background, .background, VStack, ScrollView
            if let scrollView = getScrollView(from: uiView) {
                if ScrollDetector.maxOffset == 0 {
                    ScrollDetector.maxOffset = 300
                }
                if ScrollDetector.startingOffset == 0 {
                    ScrollDetector.startingOffset = scrollView.contentOffset.y
                }
                scrollView.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    /// ScrolLView Delegate Methods
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollDetector
        
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        
        var isDelegateAdded: Bool = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
    }
}
