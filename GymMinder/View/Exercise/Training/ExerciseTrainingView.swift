//
//  ExerciseTrainingView.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI

struct ExerciseTrainingView: View {
    @StateObject var vm: ExerciseTrainingViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    SegmentProgressView(max: vm.totalSets, current: $vm.completedSets)
                        .frame(width: 100)
                        .shadow(radius: 1)
                    Text("Sets: \(vm.completedSets) / \(vm.totalSets)")
                        .font(.footnote)
                }
                .frame(width: .infinity)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Reps:")
                        .font(.subheadline)
                    Text("\(vm.reps)")
                        .font(.headline)
                }
                .frame(width: .infinity)
            }
            .padding(.top, 4)
            HStack(alignment: .bottom) {
                Button {
                    vm.addSeconds(-15)
                } label: {
                    Circle()
                        .fill(Color.gray.opacity(0.12))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text("-15s")
                                .font(.footnote)
                                .bold()
                        }
                }
                .disabled(!vm.isResting)
                if (vm.isResting) {
                    CircularTimerView(totalMs: vm.startingRestTime, leftMs: $vm.leftRestTime)
                        .font(.title3)
                        .shadow(color: .gray.opacity(0.85), radius: 5)
                } else {
                    HoldButton(holdTime: 1, hasLongHolded: $vm.isResting, onHoldingCompletion: vm.completeSet)
                        .font(.title3)
                        .overlay {
                            Text(vm.isSetButtonTappable ? "Hold If Did Set💪" : "You've finished!👏")
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                                .padding()
                        }
                        .allowsHitTesting(vm.isSetButtonTappable)
                        .shadow(color: .gray.opacity(0.85), radius: 5)
                }
                Button {
                    vm.addSeconds(15)
                } label : {
                    Circle()
                        .fill(Color.gray.opacity(0.12))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text("+15s")
                                .font(.footnote)
                                .bold()
                        }
                }
                .disabled(!vm.isResting)
            }
        }
        .alert("Rest Time Over!", isPresented: $vm.showRestAlert) {
            Button("OK", role: .cancel, action: {})
        }
    }
}
