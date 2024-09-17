//
//  UserDefaultsManager.swift
//  NewsApplication
//
//  Created by Ayush on 16/09/24.
//

import Foundation

class UserDefaultsManager: LayoutManagerProtocol {
    
    private let userDefaultsKey = "isGridView"

    func saveLayoutPreference(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: userDefaultsKey)
    }

    func getLayoutPreference() -> Bool {
        return UserDefaults.standard.bool(forKey: userDefaultsKey)
    }
}

