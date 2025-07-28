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
    let id: UUID = UUID()
    let name: String
    let imageName: String
    let equipment: Equipment
    let exType: ExType
    let instructions: String
    var weight: Float?
    var breakTime: Float?
    var sets: Int?
    var reps: Int?
}
