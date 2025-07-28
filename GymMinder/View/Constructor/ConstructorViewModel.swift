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
    @Published var exerciseType: ExType = .bodyweight
    @Published var equipment: Equipment = .none
    
    @Published var showImage = false
    
    @Published var weight = ""
    @Published var repeats = ""
    @Published var sets = ""
    @Published var breakTime = ""
    
    var editingExercise: Exercise?
    
    init(exercise: Exercise?) {
        guard let exercise = exercise else { return }
        self.name = exercise.name!
        self.instructions = exercise.instructions!
        self.exerciseType = ExType(rawValue: exercise.exType!)!
        self.equipment = Equipment(rawValue: exercise.equipment!)!
        // TODO: Image showing
        self.weight = exercise.weight == nil ? "" : "\(exercise.weight!)"
        self.repeats = exercise.reps == nil ? "" : "\(exercise.reps!)"
        self.sets = exercise.sets == nil ? "" : "\(exercise.sets!)"
        self.breakTime = exercise.breakTime == nil ? "" : "\(exercise.breakTime!)"
        self.editingExercise = exercise
    }
    
    // MARK: - Public methods
    func isInputDataValid() -> Bool {
        return !name.isEmpty && !instructions.isEmpty &&
                weight.isDecimalNumber && repeats.isNumber &&
                sets.isNumber && breakTime.isDecimalNumber
    }
    
    func prepareExercise() -> Exercise? {
        var newExercise: Exercise
        if let editingExercise = editingExercise {
            newExercise = editingExercise
        } else {
            newExercise = Exercise(context: CoreDataStack.shared.context)
        }
        newExercise.name = name
        newExercise.instructions = instructions
        newExercise.equipment = equipment.rawValue
        newExercise.exType = exerciseType.rawValue
        // TODO: Add actual image adding
        newExercise.imageName = "testTrainingStaicIm"
        newExercise.breakTime = nil
        newExercise.reps = nil
        newExercise.sets = nil
        newExercise.weight = nil
        if let breakTimeDouble = Double(breakTime) {
            newExercise.breakTime = NSNumber(floatLiteral: breakTimeDouble)
        }
        if let repeatsInt = Int(repeats) {
            newExercise.reps = NSNumber(integerLiteral: repeatsInt)
        }
        if let setsInt = Int(sets) {
            newExercise.sets = NSNumber(integerLiteral: setsInt)
        }
        if let weightDouble = Double(weight) {
            newExercise.weight = NSNumber(floatLiteral: weightDouble)
        }
        if editingExercise == nil {
            newExercise.createDate = Date()
        }
        CoreDataStack.shared.saveContext()
        return newExercise
    }
}
