//
//  AppDelegate.swift
//  Wallet
//
//  Created by Вадим Воляс on 21.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if AuthorizeManager.shared.isUserAuthorize() {
            window?.rootViewController = UINavigationController(rootViewController: MainBuilder.build())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LoginBuilder.build())
        }
        return true
    }
    
    static var shared: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    func changeRoot(viewController: UIViewController) {
        window?.rootViewController = viewController
    }
}

