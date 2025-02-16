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
                TimerSkipButton(buttonTitle: "arrow.counterclockwise") {
                    vm.timer.addSeconds(-15)
                }
                .disabled(!vm.hasBreak)
                if (vm.hasBreak) {
                    CircularTimerView(totalMs: breakTimer.startingTime, leftMs: $breakTimer.leftTime)
                        .font(.title3)
                        .shadow(color: .gray.opacity(0.85), radius: 5)
                } else {
                    HoldButton(holdTime: 1, hasLongHolded: $vm.hasBreak, onHoldingCompletion: vm.completeSet)
                        .font(.title3)
                        .overlay {
                            Text(vm.holdButtonText)
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                                .minimumScaleFactor(0.5)
                                .padding()
                        }
                        .allowsHitTesting(vm.isSetButtonTappable)
                        .shadow(color: .gray.opacity(0.85), radius: 5)
                }
                TimerSkipButton(buttonTitle: "arrow.clockwise") {
                    vm.timer.addSeconds(15)
                }
                .disabled(!vm.hasBreak)
            }
        }
        Button {
            print("Hi")
        } label: {
            Text("Go to next")
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .background(Color.green.opacity(0.7))
        .clipShape(.buttonBorder)
    }
}

struct TimerSkipButton: View {
    let buttonTitle: String
    let onButtonTap: () -> Void
    
    var body: some View {
        Button {
            onButtonTap()
        } label: {
            Image(systemName: buttonTitle)
                .font(.title)
                .overlay {
                    Text("15")
                        .font(.caption2)
                        .bold()
                        .offset(y: 3)
                }
        }
    }
}
