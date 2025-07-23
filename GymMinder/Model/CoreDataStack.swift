//
//  CoreDataStack.swift
//  GymMinder
//
//  Created by Serik Musaev on 20.07.2025.
//

import Foundation

// MARK: - Mock CoreDataStack
final class CoreDataStack {
    static var exercises: [Exercise] = [
        Exercise(name: "Push-ups", imageName: "testAnimation", equipment: .none, exType: .bodyweight, sets: 4, reps: 10, weight: nil, breakTime: 60, instructions:
                """
                Place your hands shoulder-width apart on the floor. \n
                Extend your legs straight behind you, with your toes touching the ground. \n
                Keep your body in a straight line from head to heels. Engage your core and glutes. \n
                Slowly lower your body by bending your elbows until your chest is just above the floor. \n
                Press through your palms to push your body back up to the starting position. \n
                Repeat for the required reps.
                """
                ),
        Exercise(name: "Squats", imageName: "testAnimation", equipment: .none, exType: .bodyweight, sets: 4, reps: 10, weight: 50, breakTime: 90, instructions: ""),
        Exercise(name: "Deadlifts", imageName: "testAnimation", equipment: .none, exType: .bodyweight,  sets: 3, reps: 8, weight: 80, breakTime: 120, instructions: ""),
        Exercise(name: "Bicep Curls", imageName: "testAnimation", equipment: .none, exType: .bodyweight, sets: 3, reps: 15, weight: 10, breakTime: 45, instructions: "")
    ]
    
    func getExercises() -> [Exercise] {
        print("Bicep Curls sets, CDS: \(Self.exercises.last?.sets)")
        return Self.exercises
    }
    
    func addExercise(_ exercise: Exercise) {
        Self.exercises.append(exercise)
    }
}
