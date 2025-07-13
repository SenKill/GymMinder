//
//  ExerciseListView.swift
//  GymMinder
//
//  Created by Serik Musaev on 05.07.2025.
//

import SwiftUI

struct ExerciseListRowView: View {
    let exercise: Exercise
    
    var body: some View {
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
        .contentShape(Rectangle())
    }
}

struct ExerciseListView: View {
    @StateObject var vm = ExerciseListViewModel()
    
    var body: some View {
        NavigationStack {
            List($vm.exercises, editActions: .delete) { exercise in
                ExerciseListRowView(exercise: exercise.wrappedValue)
                    .onTapGesture {
                        vm.selectedExercise = exercise.wrappedValue
                        vm.isConstructorPresent = true
                    }
            }
            .sheet(isPresented: $vm.isConstructorPresent) {
                ConstructorView(isConstructorOpen: $vm.isConstructorPresent, vm: ConstructorViewModel(exercise: vm.selectedExercise), onSubmit: vm.saveNewExercise)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        vm.selectedExercise = nil
                        vm.isConstructorPresent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }
}

#Preview {
    ExerciseListView()
}
