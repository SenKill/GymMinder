//
//  ProgramViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 12.02.2025.
//

import Foundation
import SwiftUI

// MARK: - Sample Data

final class ProgramViewModel: ObservableObject {
    // Hardcoded samples, load from core data later
    var exercises = [
        Exercise(name: "Push-ups", sets: 3, reps: 12, weight: "Bodyweight", breakTime: 60, imageName: "pushups", instructions: [
            InstructionSection(title: "How to Perform a Proper Push-Up", steps: [
                "Place your hands shoulder-width apart on the floor.",
                "Extend your legs straight behind you, with your toes touching the ground.",
                "Keep your body in a straight line from head to heels. Engage your core and glutes.",
                "Slowly lower your body by bending your elbows until your chest is just above the floor.",
                "Press through your palms to push your body back up to the starting position.",
                "Repeat for the required reps."
            ]),
            InstructionSection(title: "Common Mistakes to Avoid", steps: [
                "✅ **Sagging Hips:** Keep your core tight to maintain a straight back.",
                "✅ **Flaring Elbows:** Keep them at a 45-degree angle to avoid shoulder strain.",
                "✅ **Incomplete Range of Motion:** Lower yourself properly and push all the way up.",
                "✅ **Rushing the Movement:** Maintain a controlled pace for better muscle activation."
            ]),
            InstructionSection(title: "Modifications for All Levels", steps: [
                "🟢 **Beginner:** Perform push-ups on your knees or against a wall.",
                "🟠 **Intermediate:** Standard push-ups with full range of motion.",
                "🔴 **Advanced:** Try diamond push-ups, archer push-ups, or clap push-ups for more difficulty."
            ]),
            InstructionSection(title: "Muscles Worked", steps: [
                "✔️ Chest (Pectorals)",
                "✔️ Triceps",
                "✔️ Shoulders (Deltoids)",
                "✔️ Core (Abdominals)"
            ]),
            InstructionSection(title: "Additional Training Tips", steps: [
                "💡 Maintain a steady breathing pattern – inhale as you lower, exhale as you push up.",
                "💡 Aim for **controlled movement** rather than speed.",
                "💡 Track your progress by increasing reps, sets, or difficulty over time."
            ])
        ]),
        Exercise(name: "Squats", sets: 4, reps: 10, weight: "50 kg", breakTime: 90, imageName: "squats", instructions: []),
        Exercise(name: "Deadlifts", sets: 3, reps: 8, weight: "80 kg", breakTime: 120, imageName: "deadlifts", instructions: []),
        Exercise(name: "Bicep Curls", sets: 3, reps: 15, weight: "10 kg", breakTime: 45, imageName: "bicep_curls", instructions: [])
    ]
    
    private var exerciseViewModels: [ExerciseViewModel]
    private var alertManager: AlertManager
    
    init(alertManager: AlertManager) {
        self.alertManager = alertManager
        self.exerciseViewModels = []
        // Setting up completions for each view model to:
        self.exerciseViewModels = self.exercises.map {
            let exVm = ExerciseViewModel(exercise: $0)
            // To show alert even if user is not in the right exercise view
            exVm.onBreakFinish = { timer in
                let alert = Alert(
                    title: Text("Rest Time Over!"),
                    message: Text("For \"\(timer.exerciseName)\" exercise"),
                    dismissButton: .default(Text("OK")))
                alertManager.enqueue(alert)
            }
            return exVm
        }
    }
    
    func getExerciseVm(with id: UUID) -> ExerciseViewModel {
        // Maybe fatal error in the future
        return self.exerciseViewModels.first(where: { $0.exercise.id == id })!
    }
    
    func isExerciseFinished(_ exercise: Exercise) -> Bool {
        let exVm = getExerciseVm(with: exercise.id)
        return exVm.completedSets >= exercise.sets
    }
}
