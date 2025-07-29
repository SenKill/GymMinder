//
//  PlannerRowView.swift
//  GymMinder
//
//  Created by Serik Musaev on 13.07.2025.
//

import SwiftUI

struct PlannerRowView: View {
    @Binding var exercise: ExerciseOverview
    @FocusState private var focusedField: String?
    let index: Int

    init(exercise: Binding<ExerciseOverview>, index: Int) {
        self._exercise = exercise
        self.index = index + 1
    }

    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("\(index).")
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
                                    .stroke(
                                        Color.gray.opacity(0.5), lineWidth: 1)
                            }
                        )
                    Text(exercise.name)
                        .font(.title3)
                        .frame(width: 90, alignment: .leading)
                    Spacer()
                    VStack(spacing: 10) {
                        ParameterSelector(
                            title: "Sets:", counter: $exercise.sets)
                        ParameterSelector(
                            title: "Reps:", counter: $exercise.reps)
                    }
                }
                ParameterField(
                    title: "Weight", unit: "kg", val: $exercise.weight,
                    focusedField: $focusedField,
                    isValid: $exercise.isWeightValid,
                    convertNumber: { strNum in
                        return Float(strNum)
                    }
                )
                .keyboardType(.decimalPad)
                .focused($focusedField, equals: "Weight")
                ParameterField(
                    title: "Break Time", unit: "seconds break",
                    val: $exercise.breakTime, focusedField: $focusedField,
                    isValid: $exercise.isBreakTimeValid,
                    convertNumber: { strNum in
                        return Int(strNum)
                    }
                )
                .keyboardType(.numberPad)
                .focused($focusedField, equals: "Break Time")
            }
        }
    }
}

struct ParameterSelector: View {
    let title: String
    @Binding var counter: Int

    var body: some View {
        HStack {
            Button {
                if counter > 0 {
                    counter -= 1
                }
            } label: {
                Image(systemName: "minus")
            }
            Text(title)
                .frame(width: 50, alignment: .trailing)
            Text("\(counter)")
                .frame(width: 30, alignment: .leading)
            Button {
                counter += 1
            } label: {
                Image(systemName: "plus")
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ParameterField<T>: View {
    let title: String
    let unit: String
    @Binding var val: T?
    @State private var valStr: String = "" {
        didSet {
            print("valStr")
        }
    }
    @FocusState.Binding var focusedField: String?
    @Binding var isValid: Bool
    var convertNumber: ((String) -> T?)

    var body: some View {
        HStack {
            TextField(
                title,
                text: .init(
                    get: {
                        valStr
                    },
                    set: { newVal in
                        valStr = newVal.replacingOccurrences(of: ",", with: ".")
                        val = convertNumber(newVal)
                        isValid = val != nil
                    })
            )
            .textFieldStyle(.roundedBorder)
            .frame(width: 120)
            .onAppear {
                valStr = val == nil ? "" : "\(val!)"
            }
            Text(unit)
        }
    }
}

#Preview {
    List {
        PlannerRowView(
            exercise:
                .constant(
                    ExerciseOverview(
                        name: "Squats", imageName: "testAnimation",
                        equipment: .none, exType: .bodyweight,
                        instructions: "", weight: 50, breakTime: 90, sets: 4,
                        reps: 10)), index: 1)
    }
}
