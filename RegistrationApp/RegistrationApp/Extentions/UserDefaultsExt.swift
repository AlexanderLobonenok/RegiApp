//
//  UserDefaultsExt.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 11.08.22.
//

import Foundation

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case email
        case name
        case pass
    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
