//
//  AppDelegate.swift
//  aligntime
//
//  Created by Ostap on 26/11/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
           didReceive response: UNNotificationResponse,
           withCompletionHandler completionHandler:
             @escaping () -> Void) {
           
       // Get the meeting ID from the original notification.

       // Perform the task associated with the action.
       switch response.actionIdentifier {
       case "ACCEPT_ACTION":
            print("DECLINE_ACTION")
          break
            
       case "DECLINE_ACTION":
            print("DECLINE_ACTION")
          break
            
       // Handle other actions…
     
       default:
          break
       }
        
       // Always call the completion handler when done.
       completionHandler()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Transform each favorite contact into a UIApplicationShortcutItem.
        application.shortcutItems = [UIApplicationShortcutItem(type: "FavoriteAction",
                                             localizedTitle: "asd",
                                             localizedSubtitle: "aqq",
                                             icon: UIApplicationShortcutIcon(type: .contact))]
        
    }
    
}

