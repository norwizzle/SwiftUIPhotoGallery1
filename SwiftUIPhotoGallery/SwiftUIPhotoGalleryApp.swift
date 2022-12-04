//
//  SwiftUIPhotoGalleryApp.swift
//  SwiftUIPhotoGallery
//
//  Created by Norwin Uy on 2022-12-03.
//

import SwiftUI

@main
struct SwiftUIPhotoGalleryApp: App {
    
    init() {
        UINavigationBar.applyCustomAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

fileprivate extension UINavigationBar {
    
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
