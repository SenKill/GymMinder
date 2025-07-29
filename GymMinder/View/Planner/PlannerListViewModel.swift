//
//  PlannerListViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 15.07.2025.
//

import SwiftUI

final class PlannerListViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var exercises: [ExerciseOverview] = []
    @Published var isExerciseListOpened: Bool = false
    @Published var hasStartedTraining: Bool = false
    @Published var programName: String = ""
    
    var isPlanReady: Bool {
        if exercises.isEmpty || programName.isEmpty { return false }
        for ex in exercises {
            if !ex.isWeightValid || !ex.isBreakTimeValid || ex.sets == 0 || ex.reps == 0 {
                return false
            }
        }
        return true
    }
    
    func addExercises(_ newExercises: Set<Exercise>) {
        newExercises.forEach { ex in
            exercises.append(ExerciseOverview(src: ex))
        }
    }
    
    func deleteExercises(indexSet: IndexSet) {
        exercises.remove(atOffsets: indexSet)
    }
    
    func moveExercises(from: IndexSet, to: Int) {
        exercises.move(fromOffsets: from, toOffset: to)
    }
}
