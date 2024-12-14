//
//  DoubleExtension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation
import SwiftUI
extension Double {
    var responsizeW: Double {
        return UIScreen.main.bounds.size.width * self / 100
    }
    var responsizeH: Double {
        return UIScreen.main.bounds.size.height * self / 100
    }
    
    var toString:String{
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.numberStyle = .decimal
        number.groupingSeparator = ","
        number.decimalSeparator = "."
        number.groupingSize = 3
        number.maximumFractionDigits = 2
        return number.string(from: NSNumber(value: self)) ?? "0"
    }
    
}


extension Float {
    
    
    var toString:String{
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = ","
        number.groupingSize = 3
        
        return number.string(from: NSNumber(value: self)) ?? "0"
    }
}


extension Int {
    
    var toString:String{
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = ","
        number.groupingSize = 3
        return number.string(from: NSNumber(value: self)) ?? "0"
    }
    
}


