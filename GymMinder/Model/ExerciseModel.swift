//
//  ExerciseModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 12.02.2025.
//

import Foundation

enum Equipment: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    case none = "None"
    case freeWeights = "Free Weights"
    case cables = "Cables"
    case strengthMachine = "Strength Machine"
    case multiUseMachine = "Multi-Use Machine"
    case pullUpBar = "Pull-Up Bar"
    case parallelBars = "Parallel Bars"
}

enum ExType: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    case weights = "Weights"
    case bodyweight = "Bodyweights"
    case fullBody = "Full Body"
    case cardio = "Cardio"
    case isometric = "Isometric"
    case plyometric = "Plyometric"
    case olympic = "Olympic"
    case stretching = "Stretching"
    case yoga = "Yoga"
}

struct ExerciseOverview: Identifiable {
    let id: UUID
    let name: String
    let imageName: String
    let equipment: Equipment
    let exType: ExType
    let instructions: String
    var weight: Float?
    var breakTime: Int?
    var sets: Int
    var reps: Int
    var isWeightValid: Bool
    var isBreakTimeValid: Bool
    
    init (name: String, imageName: String, equipment: Equipment, exType: ExType, instructions: String, weight: Float?, breakTime: Int?, sets: Int, reps: Int) {
        self.id = UUID()
        self.name = name
        self.imageName = imageName
        self.equipment = equipment
        self.exType = exType
        self.instructions = instructions
        self.weight = weight
        self.breakTime = breakTime
        self.sets = sets
        self.reps = reps
        self.isWeightValid = true
        self.isBreakTimeValid = true
    }
    
    init(src: Exercise) {
        self.id = UUID()
        self.name = src.name!
        self.imageName = src.imageName!
        self.equipment = .init(rawValue: src.equipment!)!
        self.exType = .init(rawValue: src.exType!)!
        self.instructions = src.instructions!
        
        if let weight = src.weight {
            self.weight = Float(truncating: weight)
        }
        if let breakTime = src.breakTime {
            self.breakTime = Int(truncating: breakTime)
        }
        if let sets = src.sets {
            self.sets = Int(truncating: sets)
        } else {
            self.sets = 0
        }
        if let reps = src.reps {
            self.reps = Int(truncating: reps)
        } else {
            self.reps = 0
        }
        self.isWeightValid = self.weight != nil
        self.isBreakTimeValid = self.breakTime != nil
    }
}
