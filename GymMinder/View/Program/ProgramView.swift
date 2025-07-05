//
//  ProgramView.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI

// MARK: - Exercise Row View
struct ProgramRowView: View {
    let exercise: Exercise
    let isFinished: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            // Exercise Image
            Image("testTrainingStaticIm")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        if isFinished {
                            Color.green.opacity(0.7)
                                .clipShape(.rect(cornerRadius: 10))
                            Image(systemName: "checkmark")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                    }
                )
            // Exercise Info
            VStack(alignment: .leading, spacing: 5) {
                Text(exercise.name)
                    .font(.headline)
                    .bold()
                
                HStack(alignment: .top) {
                    Text("Sets: \(exercise.sets)")
                    Spacer()
                    Text("Reps: \(exercise.reps)")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                HStack(alignment: .top) {
                    Text("Weight: \(exercise.weight)")
                    Spacer()
                    Text("Rest: \(formatTime(exercise.breakTime))")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
    
    // Convert seconds to "01:30" format
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

// MARK: - Exercise List View
struct ProgramView: View {
    @ObservedObject private var vm: ProgramViewModel
    @ObservedObject private var alertManager: AlertManager
    
    init() {
        let alertMan = AlertManager()
        self.alertManager = alertMan
        self.vm = ProgramViewModel(alertManager: alertMan)
    }
    
    var body: some View {
        NavigationStack(path: $vm.exercisePath) {
            List(vm.exercises.indices, id: \.self) { idx in
                NavigationLink(value: idx) {
                    ProgramRowView(exercise: vm.exercises[idx], isFinished: vm.isExerciseFinished(with: idx))
                }
            }
            .navigationDestination(for: Int.self) { idx in
                ExerciseView(vm: vm.exerciseViewModels[idx])
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Workout Program")
        }
        .alert(isPresented: $alertManager.isPresented) {
            alertManager.dequeue()
        }
    }
}

// MARK: - Preview
struct ProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramView()
    }
}
