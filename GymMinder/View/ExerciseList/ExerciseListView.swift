//
//  ExerciseListView.swift
//  GymMinder
//
//  Created by Serik Musaev on 05.07.2025.
//

import SwiftUI

struct ExerciseListView: View {
    @StateObject var vm = ExerciseListViewModel()
    @Binding var isExerciseListOpened: Bool
    let onAddingExercises: (Set<Exercise>) -> Void
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($vm.exercises) { exercise in
                    ExerciseListRowView(
                        exercise: exercise,
                        isSelected: vm.selectedExercises.contains( exercise.wrappedValue)
                    )
                    .onTapGesture {
                        if vm.editMode {
                            vm.editingExercise = exercise.wrappedValue
                            vm.isConstructorPresent = true
                        } else {
                            vm.didSelectExercise(exercise.wrappedValue)
                        }
                    }
                }
                .onDelete(perform: vm.deleteExercise)
            }
            .sheet(isPresented: $vm.isConstructorPresent) {
                ConstructorView(isConstructorOpen: $vm.isConstructorPresent, vm: ConstructorViewModel(exercise: vm.editingExercise), onSubmit: vm.saveNewExercise)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        onAddingExercises(vm.selectedExercises)
                        isExerciseListOpened = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(vm.editMode ? "Select" : "Edit") {
                        vm.editMode.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        vm.editingExercise = nil
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
    ExerciseListView(isExerciseListOpened: .constant(true), onAddingExercises: { _ in })
}
