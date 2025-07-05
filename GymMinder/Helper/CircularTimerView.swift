//
//  CircularTimerView.swift
//  GymMinder
//
//  Created by Serik Musaev on 10.02.2025.
//

import SwiftUI

struct CircularTimerView: View {
    let totalMs: Double
    @Binding var leftMs: Double
    var showLeftTime: Bool = true
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 20)
                .contentShape(.circle)
            Circle()
                .trim(from: 0, to: min(leftMs / totalMs, 1))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color.green, Color.blue]), center: .center),
                        style: StrokeStyle(lineWidth: 12,
                        lineCap: .butt,
                        lineJoin: .miter,
                        dash: [4]))
                .rotationEffect(Angle(degrees: 270))
                .animation(.interactiveSpring(duration: 0.4), value: leftMs)
                .shadow(color: .green.opacity(0.6), radius: 7)
            if showLeftTime {
                Text(String(format: "%02d:%02d", Int(leftMs)/600,((Int(leftMs)/10)%60)))
                    .monospaced()
            }
        }
        .padding()
        .shadow(color: .gray.opacity(0.85), radius: 5)
    }
}

#Preview {
    CircularTimerView(totalMs: 100, leftMs: .constant(50))
}
