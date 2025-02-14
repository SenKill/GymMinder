//
//  BreakTimer.swift
//  GymMinder
//
//  Created by Serik Musaev on 13.02.2025.
//

import Foundation
import SwiftUI

final class BreakTimer: ObservableObject {
    // 1) Completion handler; 2) Using weak pointer to the view model
    let exerciseId: UUID
    let exerciseName: String
    
    @Published var leftTime: Double
    @Published var startingTime: Double
    
    private var timer: Timer?
    private let totalTime: Double
    
    init(exerciseId: UUID, exerciseName: String, totalTime: Int) {
        self.exerciseId = exerciseId
        self.exerciseName = exerciseName
        let breakTime = Double(totalTime) * 10.0
        self.totalTime = breakTime
        self.startingTime = breakTime
        self.leftTime = breakTime
    }
    
    func start(onFinishing: @escaping () -> Void) {
        timer?.invalidate()
        startingTime = totalTime
        leftTime = totalTime
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if leftTime > 0 {
                leftTime -= 1
            } else {
                timer?.invalidate()
                onFinishing()
            }
        }
    }
    
    func addSeconds(_ seconds: Double) {
        let milisecs: Double = seconds * 10
        leftTime += milisecs
        startingTime += milisecs
        if leftTime < 0 {
            leftTime = 0
        }
        if startingTime <= 0 {
            startingTime = 10
        }
    }
}
