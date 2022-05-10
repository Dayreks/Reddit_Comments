//
//  Reddit_CommentsApp.swift
//  Reddit_Comments
//
//  Created by Bohdan on 29.04.2022.
//

import SwiftUI

@main
struct Reddit_CommentsApp: App {
    @State var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
