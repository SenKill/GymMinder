//
//  SegmentProgressView.swift
//  GymMinder
//
//  Created by Serik Musaev on 09.02.2025.
//

import SwiftUI

struct SegmentProgressView: View {
    let max: Int
    @Binding var current: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(0 ..< max, id: \.self) { idx in
                (current > idx ? Color.green : Color.secondary.opacity(0.5))
                    .cornerRadius(5)
                    .animation(.smooth, value: current)
            }
            .frame(height: 10)
        }
        .padding(12)
        .background {
            Color.white.opacity(0.2)
                .clipShape(.buttonBorder)
        }
    }
}

#Preview {
    SegmentProgressView(max: 5, current: .constant(3))
}
