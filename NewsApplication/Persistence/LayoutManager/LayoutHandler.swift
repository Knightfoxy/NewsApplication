//
//  LayoutHandler.swift
//  NewsApplication
//
//  Created by Ayush on 16/09/24.
//

import SwiftUI
import Combine

class LayoutHandler: ObservableObject {
    @Published var isGridView: Bool = false
    private var layoutManager: LayoutManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    private let userDefaultsKey = "isGridView"
    
    init(layoutManager: LayoutManagerProtocol) {
        self.layoutManager = layoutManager
        self.isGridView = layoutManager.getLayoutPreference()
    }
    
    func toggleViewLayout() {
        isGridView.toggle()
    }
    
    func saveLayoutToPersistent() {
        layoutManager.saveLayoutPreference(isGridView)
    }
}

