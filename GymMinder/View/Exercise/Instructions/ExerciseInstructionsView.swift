//
//  ExerciseInstructionsView.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI

struct ExerciseInstructionsView: View {
    @StateObject var vm = ExerciseInstructionsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(vm.instructions, id: \.title) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(section.title)
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 5)
                        
                        ForEach(section.steps, id: \.self) { step in
                            Text("• \(.init(step))")
                                .font(.body)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
}
