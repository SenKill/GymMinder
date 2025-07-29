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
                List {
                    ForEach(Array($vm.exercises.enumerated()), id: \.element.id) { (index, exercise) in
                        PlannerRowView(exercise: exercise, index: index)
                    }
                    .onDelete(perform: vm.deleteExercises)
                    .onMove(perform: vm.moveExercises)
                    Color.clear
                        .frame(height: 50)
                }
                .listStyle(.plain)
                .overlay(alignment: .bottom) {
                    Button(action: {
                        vm.hasStartedTraining = true
                    }, label: {
                        Text("Start training")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    })
                    .background(.orange.opacity(vm.isPlanReady ? 1 : 0.3))
                    .clipShape(.buttonBorder)
                    .padding(.horizontal)
                    .disabled(!vm.isPlanReady)
                }
            }
            .fullScreenCover(isPresented: $vm.hasStartedTraining) {
                ProgramView(exercises: vm.exercises)
            }
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

#Preview {
    PlannerListView()
}
