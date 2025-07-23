//
//  PlannerListView.swift
//  GymMinder
//
//  Created by Serik Musaev on 15.07.2025.
//

import SwiftUI

struct PlannerListView: View {
    @StateObject var vm = PlannerListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                TextField("Program name", text: $vm.programName)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Divider()
                List($vm.exercises, editActions: .delete) { exercise in
                    PlannerRowView(exercise: exercise)
                }
                .listStyle(.plain)
                .sheet(isPresented: $vm.isExerciseListOpened) {
                    ExerciseListView(isExerciseListOpened: $vm.isExerciseListOpened, onAddingExercises: vm.addExercises)
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            vm.isExerciseListOpened = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    PlannerListView()
}
