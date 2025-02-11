//
//  GifView.swift
//  GymMinder
//
//  Created by Serik Musaev on 07.02.2025.
//

import SwiftUI
import UIKit
import WebKit


struct GifView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        webView.isOpaque = true
        webView.scrollView.isScrollEnabled = false
        
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            let data = try? Data(contentsOf: url)
            webView.load(data ?? Data(), mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

#Preview {
    GifView(gifName: "testAnimation")
}
