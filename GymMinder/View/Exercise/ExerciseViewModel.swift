//
//  ExerciseViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI
import AVFoundation

final class ExerciseViewModel: ObservableObject {
    // MARK: - Properties
    let exercise: Exercise
    
    @Published var isFavorite: Bool = false
    @Published var showTrainingView: Bool = true
    @Published var hasBreak: Bool = false
    @Published var showBreakAlert: Bool = false
    @Published var completedSets: Int = 0
    @Published var isTrainingAllowed: Bool = true
    
    var onBreakFinish: ((BreakTimer) -> Void)?
    var isSetButtonTappable: Bool {
        return completedSets != exercise.sets && isTrainingAllowed
    }
    var holdButtonText: String {
        if completedSets == exercise.sets {
            return "You've finished!👏"
        }
        if isTrainingAllowed {
            return "Hold If Did Set💪"
        }
        return "Finish your exercise First!"
    }
    
    var timer: BreakTimer
    
    init(exercise: Exercise) {
        self.exercise = exercise
        self.timer = BreakTimer(exerciseId: exercise.id, exerciseName: exercise.name, totalTime: exercise.breakTime)
    }
    
    // MARK: - Functions
    func completeSet() {
        if completedSets < exercise.sets {
            completedSets += 1
            startBreakTimer()
        }
    }
    
    func startBreakTimer() {
        hasBreak = true
        showBreakAlert = false
        timer.start { [weak self] in
            guard let self = self else { return }
            withAnimation(.spring(.smooth, blendDuration: 0.14)) { [weak self] in
                self?.hasBreak = false
            }
            showBreakAlert = true
            AudioServicesPlaySystemSound(1005)
            onBreakFinish?(self.timer)
        }
    }
}
