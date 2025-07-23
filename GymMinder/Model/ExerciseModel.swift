//
//  ExerciseModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 12.02.2025.
//

import Foundation

// MARK: - Data Model
class Exercise: Identifiable, Hashable {
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
    
    var id: String { return name }
    var name: String
    var imageName: String // Exercise image
    var equipment: Equipment
    var exType: ExType
    var instructions: String
    
    var sets: Int?
    var reps: Int?
    var weight: Float?
    var breakTime: Float?
    
    init(name: String, imageName: String, equipment: Equipment, exType: ExType, sets: Int?, reps: Int?, weight: Float?, breakTime: Float?, instructions: String) {
        self.name = name
        self.imageName = imageName
        self.equipment = equipment
        self.exType = exType
        self.instructions = instructions
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.breakTime = breakTime
    }
    
    func copy(src: Exercise) {
        self.name = src.name
        self.imageName = src.imageName
        self.equipment = src.equipment
        self.exType = src.exType
        self.instructions = src.instructions
        self.sets = src.sets
        self.reps = src.reps
        self.weight = src.weight
        self.breakTime = src.breakTime
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ExerciseOverview {
    let name: String
    let imageName: String
    let equipment: String
    let exType: String
    let instructions: String
    let weight: String
    let sets: Int
    let reps: Int
    let breakTime: Int
}
