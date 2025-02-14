//
//  AlertManager.swift
//  GymMinder
//
//  Created by Serik Musaev on 13.02.2025.
//

import SwiftUI
import Combine

final class AlertManager: ObservableObject {
    @Published var isPresented = false

    private var queues: [Alert] = []
    private var cancellable: AnyCancellable?

    init() {
        cancellable = $isPresented
            .filter({ [weak self] isPresented in
                guard let self = self else {
                    return false
                }
                return !isPresented && !self.queues.isEmpty
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.isPresented = true
            })
    }

    func enqueue(_ alert: Alert) {
        queues.append(alert)
        isPresented = true
    }

    func dequeue() -> Alert {
        queues.removeFirst()
    }
}
