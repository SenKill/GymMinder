//
//  PlannerRowView.swift
//  GymMinder
//
//  Created by Serik Musaev on 13.07.2025.
//

import SwiftUI

struct PlannerRowView: View {
    @Binding var exercise: Exercise
    @FocusState private var focusedField: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image("testTrainingStaticIm")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        }
                    )
                Text(exercise.name)
                    .font(.title3)
                    .frame(width: 90, alignment: .leading)
                Spacer()
                VStack(spacing: 10) {
                    ParameterSelector(title: "Sets:", counter: $exercise.sets)
                    ParameterSelector(title: "Reps:", counter: $exercise.reps)
                }
            }
            ParameterField(title: "Weight", unit: "kg", val: $exercise.weight, focusedField: $focusedField)
            .keyboardType(.decimalPad)
            .focused($focusedField, equals: "Weight")
            ParameterField(title: "Break Time", unit: "seconds break", val: $exercise.breakTime, focusedField: $focusedField)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: "Break Time")
        }
    }
}

struct ParameterSelector: View {
    let title: String
    @Binding var counter: Int?
    
    var body: some View {
        HStack {
            Button {
                if let unwCounter = counter, unwCounter > 0 {
                    counter = unwCounter - 1
                }
            } label: {
                Image(systemName: "minus")
            }
            Text(title)
                .frame(width: 50, alignment: .trailing)
            Text("\(counter ?? 0)")
                .frame(width: 30, alignment: .leading)
            Button {
                counter = (counter ?? 0) + 1
            } label: {
                Image(systemName: "plus")
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ParameterField: View {
    let title: String
    let unit: String
    @Binding var val: Float?
    @State private var valStr: String = ""
    @FocusState.Binding var focusedField: String?
    
    var body: some View {
        HStack {
            TextField(title, text: $valStr)
            .textFieldStyle(.roundedBorder)
            .frame(width: 120)
            .onChange(of: focusedField) {
                if focusedField != title {
                    print("Validate \(title)")
                    validateField()
                }
            }
            .onAppear {
                valStr = val == nil ? "" : "\(val!)"
            }
            Text(unit)
        }
    }
    
    func validateField() {
        if (valStr.isDecimalNumber) {
            val = Float(valStr.replacingOccurrences(of: ",", with: "."))
        } else {
            valStr = val == nil ? "" : "\(val!)"
        }
    }
}

#Preview {
    List {
        PlannerRowView(exercise:
                .constant(Exercise(name: "Squats", imageName: "testAnimation", equipment: .none,
                     exType: .bodyweight, sets: 4, reps: 10,
                     weight: 50, breakTime: 90, instructions: "")))
    }
}
