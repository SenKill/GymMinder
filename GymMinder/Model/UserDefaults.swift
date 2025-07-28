//
//  UserDefaults.swift
//  GymMinder
//
//  Created by Serik Musaev on 28.07.2025.
//

import Foundation

extension UserDefaults {
    var hasLaunchedBefore: Bool {
        get { bool(forKey: "hasLaunchedBefore") }
        set { set(newValue, forKey: "hasLaunchedBefore") }
    }
}
