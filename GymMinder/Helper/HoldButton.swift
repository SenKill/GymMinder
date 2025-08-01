//
//  HoldButton.swift
//  GymMinder
//
//  Created by Serik Musaev on 10.02.2025.
//

import SwiftUI
import AVFoundation

struct HoldButton: View {
    let holdTime: Double
    let labelText: String
    var onHoldingCompletion: () -> Void
    
    @State private var currentHoldTime: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        CircularTimerView(totalMs: holdTime, leftMs: $currentHoldTime, showLeftTime: false)
            .overlay {
                Text(labelText)
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .minimumScaleFactor(0.5)
                    .padding()
            }
            .onLongPressGesture(minimumDuration: holdTime, perform: {}, onPressingChanged: toggleTimer)
    }
    
    func toggleTimer(_ didStartTouching: Bool) {
        if didStartTouching {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.currentHoldTime += 0.1
                if (self.currentHoldTime >= holdTime) {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.playSuccess()
                    onHoldingCompletion()
                }
            }
        } else {
            self.timer?.invalidate()
            self.timer = nil
            self.currentHoldTime = 0.0
        }
    }

    func playSuccess() {
        AudioServicesPlaySystemSound(1111)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

#Preview {
    HoldButton(holdTime: 1, labelText: "Test", onHoldingCompletion: {})
}

