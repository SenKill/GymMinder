//
//  SmallExtensions.swift
//  GymMinder
//
//  Created by Serik Musaev on 13.07.2025.
//

import Foundation

extension String {
    var isNumber: Bool {
        return self.isEmpty || Int(self) != nil
    }
    
    var isDecimalNumber: Bool {
        return self.isEmpty || Float(self.replacingOccurrences(of: ",", with: ".")) != nil
    }
}
