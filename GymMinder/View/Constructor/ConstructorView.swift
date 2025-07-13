//
//  ConstructorView.swift
//  GymMinder
//
//  Created by Serik Musaev on 05.07.2025.
//

import SwiftUI


enum ConstructorField: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case weight = "Weight"
    case repeats = "Repeats"
    case sets = "Sets"
    case breakTime = "Break in Between Sets"
    
    var unitName: String {
        switch self {
        case .weight:
            return "kg"
        case .repeats, .sets:
            return "times"
        case .breakTime:
            return "seconds"
        }
    }
}

struct ConstructorView: View {
    @Binding var isConstructorOpen: Bool
    @ObservedObject var vm: ConstructorViewModel
    let onSubmit: (Exercise) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Exercise name", text: $vm.name)
                        .font(.title2)
                        .autocorrectionDisabled()
                    Button(action: {
                        vm.showImage.toggle()
                    }, label: {
                        if !vm.showImage {
                            Text("Add an image/GIF")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundStyle(Color.white)
                        } else {
                            Image("testTrainingStaticIm")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        }
                    })
                    .border(.gray, width: 1)
                    .clipShape(.rect(cornerRadius: 8))
                }
                Section(header: Label("Required", systemImage: "exclamationmark.circle.fill")) {
                    
                    
                    Picker("Type", selection: $vm.exerciseType) {
                        ForEach(Exercise.ExType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }
                    
                    Picker("Equipment", selection: $vm.equipment) {
                        ForEach(Exercise.Equipment.allCases) { equipment in
                            Text(equipment.rawValue)
                                .tag(equipment)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Instructions:")
                        TextEditor(text: $vm.instructions)
                            .textFieldStyle(.roundedBorder)
                            .frame(minHeight: 40)
                    }
                }
                Section(header: Label("Optional", systemImage: "arrow.triangle.2.circlepath")) {
                    ForEach(ConstructorField.allCases) { field in
                        OptionalField(field: field, text: getFieldText(for: field))
                    }
                }
                .textFieldStyle(.roundedBorder)
            }
            .navigationTitle(vm.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        isConstructorOpen = false
                        onSubmit(vm.prepareExercise())
                    } label: {
                        Text("Save")
                    }
                    .disabled(!vm.isInputDataValid())
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isConstructorOpen = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    func getFieldText(for field: ConstructorField) -> Binding<String> {
        switch field {
        case .weight:
            return $vm.weight
        case .sets:
            return $vm.sets
        case .repeats:
            return $vm.repeats
        case .breakTime:
            return $vm.breakTime
        }
    }
}

struct OptionalField: View {
    fileprivate let field: ConstructorField
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(field.rawValue)
                .font(.caption)
                .padding(.leading, 3)
                .foregroundStyle(.secondary)
            HStack {
                TextField(field.rawValue, text: $text)
                    .keyboardType(field == .weight ? .decimalPad : .numberPad)
                    .textFieldStyle(.roundedBorder)
                Text(field.unitName)
                    .frame(width: 60, alignment: .leading)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ConstructorView(isConstructorOpen: .constant(true), vm: ConstructorViewModel(exercise: nil), onSubmit: {_ in})
}

