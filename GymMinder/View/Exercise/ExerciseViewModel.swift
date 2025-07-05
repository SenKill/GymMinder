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
    let exerciseCount: Int
    let exerciseIdx: Int
    let updateNavigationPath: ((Int?) -> Void)
    
    var onBreakFinish: ((BreakTimer) -> Void)?
    var holdButtonText: String {
        if completedSets == exercise.sets {
            if exerciseIdx + 1 == exerciseCount {
                return "You've done all exercises!🎉\nHold to go to home"
            }
            return "You've finished this exercise!👏\nHold to go to the next"
        }
        if isTrainingAllowed {
            return "Hold If Did Set💪"
        }
        return "Finish your exercise First!"
    }
    
    var timer: BreakTimer
    
    init(exercise: Exercise, exerciseIdx: Int, exerciseCount: Int, updatePath: @escaping (Int?) -> Void) {
        self.exercise = exercise
        self.timer = BreakTimer(exerciseId: exercise.id, exerciseName: exercise.name, totalTime: exercise.breakTime)
        self.exerciseIdx = exerciseIdx
        self.exerciseCount = exerciseCount
        self.updateNavigationPath = updatePath
    }
    
    // MARK: - Functions
    func onHoldButton() {
        if completedSets < exercise.sets {
            completedSets += 1
            startBreakTimer()
        } else {
            // Go to the next exercise
            // Run a completion
            if (exerciseIdx + 1) < exerciseCount {
                self.updateNavigationPath(exerciseIdx+1)
            } else if (exerciseIdx + 1) == exerciseCount {
                self.updateNavigationPath(nil)
            }
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
