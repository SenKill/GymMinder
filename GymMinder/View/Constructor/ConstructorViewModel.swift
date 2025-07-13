//
//  ConstructorViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 09.07.2025.
//

import SwiftUI

final class ConstructorViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var name = ""
    @Published var instructions = ""
    @Published var exerciseType: Exercise.ExType = .bodyweight
    @Published var equipment: Exercise.Equipment = .none
    
    @Published var showImage = false
    
    @Published var weight = ""
    @Published var repeats = ""
    @Published var sets = ""
    @Published var breakTime = ""
    
    init(exercise: Exercise?) {
        guard let exercise = exercise else { return }
        self.name = exercise.name
        self.instructions = exercise.instructions
        self.exerciseType = exercise.exType
        self.equipment = exercise.equipment
        // TODO: Image showing
        self.weight = exercise.weight == nil ? "" : "\(exercise.weight!)"
        self.repeats = exercise.reps == nil ? "" : "\(exercise.reps!)"
        self.sets = exercise.sets == nil ? "" : "\(exercise.sets!)"
        self.breakTime = exercise.breakTime == nil ? "" : "\(exercise.breakTime!)"
    }
    
    // MARK: - Public methods
    func isInputDataValid() -> Bool {
        return !name.isEmpty && !instructions.isEmpty &&
                weight.isDecimalNumber && repeats.isNumber &&
                sets.isNumber && breakTime.isNumber
    }
    
    func prepareExercise() -> Exercise {
        // TODO: Add actual image adding
        let exercise = Exercise(
            name: name, imageName: "", equipment: equipment, exType: exerciseType, sets: Int(sets),
            reps: Int(repeats), weight: Float(weight), breakTime: Int(breakTime), instructions: instructions)
        return exercise
    }
}
