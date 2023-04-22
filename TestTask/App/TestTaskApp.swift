//
//  TestTaskApp.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import SwiftUI
import SDWebImage
import SDWebImageSVGCoder

@main
struct TestTaskApp: App {
    @StateObject var viewModel = ContentViewViewModel()

        init() {
            setUpDependencies() // Initialize SVGCoder
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

private extension TestTaskApp {
    
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}

