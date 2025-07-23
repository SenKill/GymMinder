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
                    // Set tracker
                    if vm.showTrainingView {
                        ExerciseTrainingView(vm: vm)
                        Spacer()
                    }
                }
                .padding(.all)
                if !vm.showTrainingView {
                    Text(vm.exercise.instructions)
                        .padding()
                        .background(Color.white)
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
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    vm.updateNavigationPath(nil)
                } label: {
                    Image(systemName: "house.fill")
                }
            }
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        private let exercise = ExerciseOverview(
            name: "Push-ups", imageName: "pushups",
            equipment: Exercise.Equipment.none.rawValue,
            exType: Exercise.ExType.bodyweight.rawValue,
            instructions: "", weight: "Bodyweight", sets: 3, reps: 12, breakTime: 60)
        
        var body: some View {
            ExerciseView(vm: ExerciseViewModel(exercise: exercise, exerciseIdx: 0, exerciseCount: 1, updatePath: { _ in }))
        }
    }
    return PreviewWrapper()
}
