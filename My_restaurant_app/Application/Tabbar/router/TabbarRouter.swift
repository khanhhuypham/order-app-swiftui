//
//  TabbarRouter.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI
import Foundation
class TabBarViewModel:ObservableObject{
    @Published var currentPage:Page = .order
    @Published var isTabbarHidden:Bool = true
}


enum Page{
    case order
    case area
    case Utility
    
    
    var title:String{
        switch self {
            case .order:
                return "Dơn hàng"
            case .area:
                return "Khu vực"
        
            case .Utility:
                return "Tiện tích"
            
         
        }
    }
    
    var iconName:String{
        switch self{
            case .order:
                return "house.fill"
            case .area:
                return "newspaper.fill"
          
            case .Utility:
                return "person.crop.circle.fill"
            
        }
    }
}
