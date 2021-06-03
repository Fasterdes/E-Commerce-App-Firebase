//
//  E_CommerceApp.swift
//  E-Commerce
//
//  Created by Fa Ainama Caldera S on 01/03/21.
//

// Import Firebase adalah Mengimport databasess firebase menggunakan Cocoapod

import SwiftUI
import Firebase

@main
struct E_CommerceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// initializing firebase
class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
