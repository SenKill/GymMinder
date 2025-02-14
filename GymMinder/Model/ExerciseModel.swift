//
//  ExerciseModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 12.02.2025.
//

import Foundation

// MARK: - Data Model
final class Exercise: Identifiable {
    let id = UUID()
    let name: String
    let sets: Int
    let reps: Int
    let weight: String
    let breakTime: Int // In seconds
    let imageName: String // Exercise image
    let instructions: [InstructionSection]
    
    init(name: String, sets: Int, reps: Int, weight: String, breakTime: Int, imageName: String, instructions: [InstructionSection]) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.breakTime = breakTime
        self.imageName = imageName
        self.instructions = instructions
    }
}

struct InstructionSection {
    let title: String
    let steps: [String]
}
