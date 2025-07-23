//
//  ExerciseRowView.swift
//  GymMinder
//
//  Created by Serik Musaev on 15.07.2025.
//

import SwiftUI

struct ExerciseListRowView: View {
    @Binding var exercise: Exercise
    let isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top, spacing: 16) {
                // TODO: Add real images
                Image("testTrainingStaticIm")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        }
                    )
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    Group {
                        Text(exercise.exType.rawValue)
                        if exercise.equipment != .none {
                            Text(exercise.equipment.rawValue)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                }
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
    }
}
