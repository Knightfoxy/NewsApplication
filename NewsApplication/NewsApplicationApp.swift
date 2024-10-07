//
//  NewsApplicationApp.swift
//  NewsApplication
//
//  Created by Ayush on 16/09/24.
//

import SwiftUI

@main
struct NewsApplicationApp: App {
    @StateObject private var layoutHandler = LayoutHandler(layoutManager: UserDefaultsManager())
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NewsHome()
                .environmentObject(layoutHandler)
                .onChange(of: scenePhase) {
                    if scenePhase == .background {
                        layoutHandler.saveLayoutToPersistent()
                    }
                }
        }
    }
}
