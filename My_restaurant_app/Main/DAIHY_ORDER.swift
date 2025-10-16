//
//  DAIHY_ORDER.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation
import SwiftUI
import AlertToast


@main
struct TechresOrder: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject var appState = AppState.shared
    
    var body: some Scene {
        
        WindowGroup {
            
            switch appState.userState {
                
                case .launchAnimation:
                    EmptyView()
                
                case .notLoggedIn:
                    LoginView()
                
                case .loggedIn:
                    TabBar()
            }
            
        }.onChange(of: appState.userState) { status in
            
        }
        
    }
    
    
}


class AppState: ObservableObject {

    @Published var userState: UserState = Constants.login ? .loggedIn : .notLoggedIn {
        willSet {
            if newValue == .notLoggedIn && userState == .loggedIn {
                
            }
            
//            if newValue == .notLoggedIn {
//                ManageCacheObject.setBrand(Brand())
//                ManageCacheObject.setBranch(Branch())
//                ManageCacheObject.setSetting(Setting())
//                ManageCacheObject.saveUser(Account())
//                ManageCacheObject.setConfig(Config())
//            }
        }
    }

    static let shared = AppState()

    private init() {}
}

enum UserState {
    case launchAnimation
    case notLoggedIn
    case loggedIn
}







