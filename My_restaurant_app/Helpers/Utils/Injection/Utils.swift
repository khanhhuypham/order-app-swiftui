//
//  Utils.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation


class Utils: NSObject {
    var dateFormatter:DateFormatter
  
    //------------------------------------------------------------------------------------------------------------------------
    var timeUtils: TimeUtils = TimeUtils()
    var mathUtils: MathUtils = MathUtils()
    var settingUtils = SettingUtils()
    var permissionUtils = PermissionUtils()
    var generalUtils = GeneralUtils()
    var toastUtils = ToastUtils()
    var keyChainUtils = KeyChain()
    
    init(dateFormatter: DateFormatter = .makeDefault()) {
        self.dateFormatter = dateFormatter    
    }
}
