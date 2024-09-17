//
//  LayoutManagerProtocol.swift
//  NewsApp
//
//  Created by Ayush on 16/09/24.
//

import Foundation


protocol LayoutManagerProtocol {
    func saveLayoutPreference(_ value: Bool)
    func getLayoutPreference() -> Bool
}
