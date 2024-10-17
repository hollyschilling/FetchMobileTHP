//
//  TakeHomeProjectApp.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import SwiftUI
import Nuke

@main
struct TakeHomeProjectApp: App {
    
    init() {
        ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}
