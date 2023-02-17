//
//  AppDelegate.swift
//  Jumpgame
//
//  Created by Yura Mezhik on 23.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isAllIpad = false
    var isIpadPro = false
    var isIpad11 = false
    var isIpad12 = false
    var isIpad = false
    
    var isIphoneX = false
    var isIphonePlus = false
    var isIphone = false
    var isIphone5 = false









    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupDevice()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func setupDevice(){
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            isAllIpad = true
            
            switch UIScreen.main.nativeBounds.height{
            case 2388: isIpad11 = true; break
            case 2732: isIpad12 = true; break
            default: isIpadPro = true; break
                
            }
            if isIpad12 || isIpadPro {
                isIpad = true
            }
        case .phone:
            switch UIScreen.main.nativeBounds.height{
            case 2688, 1792, 2436, 2778: isIphoneX = true; break
            case 1920, 2208: isIphonePlus = true; break
            case 1334: isIphone = true; break
            case 1136: isIphone5 = true; break
            default: isIphoneX = true; break
            }
        case.tv: break
        default: break
        }
    }

}

