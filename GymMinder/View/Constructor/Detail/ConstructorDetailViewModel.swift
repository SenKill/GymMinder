//
//  ConstructorDetailViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 09.07.2025.
//

import SwiftUI

final class ConstructorDetailViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var name = ""
    @Published var description = ""
    @Published var showImage = false
    @Published var weight = ""
    @Published var repeats = ""
    @Published var sets = ""
    @Published var exerciseType: Exercise.ExType?
    @Published var equipment: Exercise.Equipment?
}
