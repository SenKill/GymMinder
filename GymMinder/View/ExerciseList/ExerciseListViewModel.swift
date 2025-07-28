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
    @Published var exercises: [Exercise] = []
    private let coreDataStack: CoreDataStack
    
    init() {
        coreDataStack = CoreDataStack.shared
        exercises = coreDataStack.getExercises()
    }
    
    func saveNewExercise(_ newExercise: Exercise) -> Bool {
        // Check if new/edited exercise is valid
        // Check if it has unique name
        // id = name, so I am using this approach, name must be unique
        var foundSameName = false
        for exercise in exercises {
            if exercise.name == newExercise.name {
                if foundSameName {
                    return false
                }
                foundSameName = true
            }
        }
        
        if editingExercise == nil {
            exercises.append(newExercise)
        }
        return true
    }
    
    func handleExerciseTap(_ exercise: Exercise) {
        if editMode {
            editingExercise = exercise
            isConstructorPresent = true
        } else {
            if selectedExercises.contains(exercise) {
                selectedExercises.remove(exercise)
            } else {
                selectedExercises.insert(exercise)
            }
        }
    }
    
    func deleteExercise(at indexSet: IndexSet) {
        for index in indexSet {
            coreDataStack.context.delete(exercises[index])
        }
        
        do {
            try coreDataStack.context.save()
            exercises.remove(atOffsets: indexSet)
        } catch {
            print("CoreData: Error saving after delete: \(error)")
        }
    }
}
