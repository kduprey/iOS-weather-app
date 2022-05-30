//
//  Coursework2App.swift
//  Coursework2
//
//  Created by Kenton Duprey on 5/23/22.
//

import SwiftUI

@main
struct Coursework2App: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
