//
//  AppDelegate.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var daihyOrder: DAIHYORDER?

    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    
        daihyOrder = DAIHYORDER()
        
        return true
    }
    
}



