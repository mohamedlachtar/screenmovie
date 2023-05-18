//
//  loginApp.swift
//  login
//
//  Created by Apple Esprit on 14/3/2023.
//

import SwiftUI
import FBSDKCoreKit


@main

struct constunApp: App {

    

    let persistenceController = PersistenceController.shared

  

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {

        WindowGroup {

            RootView()
            
                .onAppear(){
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                    
                }
                .onOpenURL(perform: { url in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil,annotation: UIApplication.OpenURLOptionsKey.annotation)
                
                })

                .environment(\.managedObjectContext, persistenceController.container.viewContext)

                .preferredColorScheme(isDarkMode ? .dark : .light)

        }

        .onChange(of: isDarkMode) { newValue in

                    UserDefaults.standard.set(newValue, forKey: "isDarkMode")

                }

    }

    init() {

            if let isDarkMode = UserDefaults.standard.value(forKey: "isDarkMode") as? Bool {

                self.isDarkMode = isDarkMode

            }

        }

}
