//
//  TrainingViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI
import AVFoundation

class ExerciseTrainingViewModel: ObservableObject {
    // MARK: - Properties
    var totalSets: Int
    var reps: Int
    var defaultRestTime: Double
    var startingRestTime: Double
    var isSetButtonTappable: Bool {
        return completedSets != totalSets
    }
    
    @Published var completedSets: Int = 0
    @Published var isResting: Bool = false
    @Published var showRestAlert: Bool = false
    @Published var leftRestTime: Double
    
    private var timer: Timer?
    
    init(totalSets: Int, reps: Int, defaultRestTime: Double, completedSets: Int) {
        self.totalSets = totalSets
        self.reps = reps
        self.defaultRestTime = defaultRestTime
        self.leftRestTime = defaultRestTime
        self.startingRestTime = defaultRestTime
    }
    
    // MARK: - Functions
    func completeSet() {
        if completedSets < totalSets {
            completedSets += 1
            startRestTimer()
        }
    }
    
    func startRestTimer() {
        startingRestTime = defaultRestTime
        leftRestTime = defaultRestTime
        isResting = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if leftRestTime > 0 {
                leftRestTime -= 1
            } else {
                withAnimation(.spring(.smooth, blendDuration: 0.14)) { [weak self] in
                    self?.isResting = false
                }
                showRestAlert = true
                AudioServicesPlaySystemSound(1005)
                timer?.invalidate()
            }
        }
    }
    
    func addSeconds(_ seconds: Double) {
        let milisecs: Double = seconds * 10
        leftRestTime += milisecs
        startingRestTime += milisecs
        if leftRestTime < 0 {
            leftRestTime = 0
        }
        if startingRestTime <= 0 {
            startingRestTime = 10
        }
    }
}
