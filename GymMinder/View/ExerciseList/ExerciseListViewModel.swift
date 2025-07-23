//
//  ExerciseListViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 05.07.2025.
//

import SwiftUI

final class ExerciseListViewModel: ObservableObject {
    @Published var isConstructorPresent: Bool = false
    @Published var editingExercise: Exercise? = nil
    @Published var selectedExercises: Set<Exercise> = []
    @Published var editMode: Bool = false
    private let coreDataStack: CoreDataStack
    @Published var exercises: [Exercise]
    
    init() {
        coreDataStack = CoreDataStack()
        exercises = coreDataStack.getExercises()
    }
    
    func saveNewExercise(_ exercise: Exercise) {
        // Check if exists
        if let existingIdx = exercises.firstIndex(where: {$0.name == exercise.name}) {
            exercises[existingIdx].copy(src: exercise)
            CoreDataStack.exercises[existingIdx].copy(src: exercise)
        } else {
            exercises.append(exercise)
            coreDataStack.addExercise(exercise)
        }
    }
    
    func didSelectExercise(_ exercise: Exercise) {
        if selectedExercises.contains(exercise) {
            selectedExercises.remove(exercise)
        } else {
            selectedExercises.insert(exercise)
        }
    }
    
    func deleteExercise(at offset: IndexSet) {
        CoreDataStack.exercises.remove(atOffsets: offset)
        exercises.remove(atOffsets: offset)
    }
}
