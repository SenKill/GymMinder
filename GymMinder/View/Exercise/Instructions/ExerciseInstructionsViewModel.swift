//
//  ExerciseInstructionsViewModel.swift
//  GymMinder
//
//  Created by Serik Musaev on 11.02.2025.
//

import SwiftUI

struct InstructionSection {
    let title: String
    let steps: [String]
}

class ExerciseInstructionsViewModel: ObservableObject {
    let instructions: [InstructionSection] = [
        InstructionSection(title: "How to Perform a Proper Push-Up", steps: [
            "Place your hands shoulder-width apart on the floor.",
            "Extend your legs straight behind you, with your toes touching the ground.",
            "Keep your body in a straight line from head to heels. Engage your core and glutes.",
            "Slowly lower your body by bending your elbows until your chest is just above the floor.",
            "Press through your palms to push your body back up to the starting position.",
            "Repeat for the required reps."
        ]),
        InstructionSection(title: "Common Mistakes to Avoid", steps: [
            "✅ **Sagging Hips:** Keep your core tight to maintain a straight back.",
            "✅ **Flaring Elbows:** Keep them at a 45-degree angle to avoid shoulder strain.",
            "✅ **Incomplete Range of Motion:** Lower yourself properly and push all the way up.",
            "✅ **Rushing the Movement:** Maintain a controlled pace for better muscle activation."
        ]),
        InstructionSection(title: "Modifications for All Levels", steps: [
            "🟢 **Beginner:** Perform push-ups on your knees or against a wall.",
            "🟠 **Intermediate:** Standard push-ups with full range of motion.",
            "🔴 **Advanced:** Try diamond push-ups, archer push-ups, or clap push-ups for more difficulty."
        ]),
        InstructionSection(title: "Muscles Worked", steps: [
            "✔️ Chest (Pectorals)",
            "✔️ Triceps",
            "✔️ Shoulders (Deltoids)",
            "✔️ Core (Abdominals)"
        ]),
        InstructionSection(title: "Additional Training Tips", steps: [
            "💡 Maintain a steady breathing pattern – inhale as you lower, exhale as you push up.",
            "💡 Aim for **controlled movement** rather than speed.",
            "💡 Track your progress by increasing reps, sets, or difficulty over time."
        ])
    ]
}
