//
//  ExerciseTrainingView.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI

struct ExerciseTrainingView: View {
    @ObservedObject var vm: ExerciseViewModel
    @ObservedObject var breakTimer: BreakTimer
    
    init(vm: ExerciseViewModel) {
        self.vm = vm
        self.breakTimer = vm.timer
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    SegmentProgressView(max: vm.exercise.sets, current: $vm.completedSets)
                        .frame(width: 100)
                        .shadow(radius: 1)
                    Text("Sets: \(vm.completedSets) / \(vm.exercise.sets)")
                        .font(.footnote)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Reps:")
                        .font(.subheadline)
                    Text("\(vm.exercise.reps)")
                        .font(.headline)
                }
            }
            .padding(.top, 4)
            HStack(alignment: .bottom) {
                TimerSkipButton(buttonTitle: "-15") {
                    vm.timer.addSeconds(-15)
                }
                .disabled(!vm.hasBreak)
                if (vm.hasBreak) {
                    CircularTimerView(totalMs: breakTimer.startingTime, leftMs: $breakTimer.leftTime)
                } else {
                    HoldButton(holdTime: 1, labelText: vm.holdButtonText, onHoldingCompletion: vm.onHoldButton)
                }
                TimerSkipButton(buttonTitle: "+15") {
                    vm.timer.addSeconds(15)
                }
                .disabled(!vm.hasBreak)
            }
        }
    }
}

struct TimerSkipButton: View {
    let buttonTitle: String
    let onButtonTap: () -> Void
    
    var body: some View {
        Button {
            onButtonTap()
        } label: {
            Text(buttonTitle)
                .font(.caption)
                .bold()
                .offset(y: 3)
        }
    }
}
