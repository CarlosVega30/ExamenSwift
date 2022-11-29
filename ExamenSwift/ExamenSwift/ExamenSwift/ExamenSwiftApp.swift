//
//  ExamenSwiftApp.swift
//  ExamenSwift
//
//  Created by CCDM18 on 14/11/22.
//

import SwiftUI

@main
struct ExamenSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(CoreDM: CoreDataManager())
        }
    }
}
