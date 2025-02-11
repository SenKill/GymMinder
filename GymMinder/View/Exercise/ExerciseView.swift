//
//  ExerciseView.swift
//  GymMinder
//
//  Created by Serik Musaev on 08.02.2025.
//

import SwiftUI
import AVFoundation

struct ExerciseView: View {
    let exerciseName = "Push-ups"
    let weight = "Bodyweight"
    
    @State private var isFavorite: Bool = false
    @State private var showTrainingView: Bool = true
    @StateObject private var trainingVm = ExerciseTrainingViewModel(totalSets: 3, reps: 12, defaultRestTime: 100, completedSets: 0)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                // GIF (Exercise animation)
                GifView(gifName: "testTrainingStatic") // Replace with your GIF file name
                    .disabled(true)
                    .frame(width: .infinity, height: 250)
                    .cornerRadius(12)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            isFavorite.toggle()
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(isFavorite ? .red : .secondary)
                                .frame(maxWidth: 40, maxHeight: 40)
                        }
                    }
                // Exercise Title
                Text(exerciseName)
                    .font(.title)
                    .bold()
                // Set Tracker
                HStack {
                    Text("Weight:")
                        .font(.subheadline)
                    Text(weight)
                        .font(.subheadline)
                        .bold()
                }
                Picker("Select Window", selection: $showTrainingView) {
                    Text("Training")
                        .tag(true)
                    Text("Instructions")
                        .tag(false)
                }
                .pickerStyle(.segmented)
                if showTrainingView {
                    ExerciseTrainingView(vm: trainingVm)
                    Spacer()
                }
            } // VStack
            .padding(.all)
            if !showTrainingView {
                ExerciseInstructionsView()
                    .shadow(color: .gray.opacity(0.14), radius: 2)
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
}


#Preview {
    ExerciseView()
}
