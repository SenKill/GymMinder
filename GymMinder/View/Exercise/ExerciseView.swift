//
//  ExerciseView.swift
//  GymMinder
//
//  Created by Serik Musaev on 08.02.2025.
//

import SwiftUI
import AVFoundation

struct ExerciseView: View {
    @ObservedObject var vm: ExerciseViewModel
    
    var body: some View {
        // GIF (Exercise animation)
        StretchableScrollView {
            VStack {
                VStack(alignment: .leading) {
                    // Exercise Title
                    Text(vm.exercise.name)
                        .font(.title)
                        .bold()
                    // Set Tracker
                    HStack {
                        Text("Weight:")
                            .font(.subheadline)
                        Text(vm.exercise.weight)
                            .font(.subheadline)
                            .bold()
                    }
                    Picker("Select Window", selection: $vm.showTrainingView) {
                        Text("Training")
                            .tag(true)
                        Text("Instructions")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    Divider()
                    if vm.showTrainingView {
                        ExerciseTrainingView(vm: vm)
                        Spacer()
                    }
                } // VStack
                .padding(.all)
                if !vm.showTrainingView {
                    ExerciseInstructionsView(instructions: vm.exercise.instructions)
                        .shadow(color: .gray.opacity(0.14), radius: 2)
                }
            }
            .background(Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea())
            .clipShape(.rect(cornerRadii: RectangleCornerRadii(
                topLeading: 25,
                topTrailing: 25)))
        }
        .background(Color(UIColor.systemGroupedBackground)
            .ignoresSafeArea())
        .navigationTitle(vm.exercise.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    }
}


#Preview {
    let exercise = Exercise(name: "Push-ups", sets: 3, reps: 12, weight: "Bodyweight", breakTime: 60, imageName: "pushups", instructions: [])
    ExerciseView(vm: ExerciseViewModel(exercise: exercise))
}
