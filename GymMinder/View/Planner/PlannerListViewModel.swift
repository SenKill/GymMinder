//
//  PlannerListViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 15.07.2025.
//

import SwiftUI

final class PlannerListViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var exercises: [Exercise] = []
    @Published var isExerciseListOpened: Bool = false
    @Published var programName: String = ""
    
    func addExercises(_ newExercises: Set<Exercise>) {
        newExercises.forEach { ex in
            let copyEx = Exercise(name: ex.name, imageName: ex.imageName, equipment: ex.equipment, exType: ex.exType, sets: ex.sets, reps: ex.reps, weight: ex.weight, breakTime: ex.breakTime, instructions: ex.instructions)
            exercises.append(copyEx)
        }
    }
    
    // TODO: Add future logic for starting exercising programs (transition to program module)
}
