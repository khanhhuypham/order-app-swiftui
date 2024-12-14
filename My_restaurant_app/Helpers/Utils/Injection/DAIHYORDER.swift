//
//  DAIHYORDER.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation


class DAIHYORDER {
 
    var appearance: Appearance
    var utils: Utils
    
    public init(appearance: Appearance = Appearance(),utils: Utils = Utils()) {
        self.appearance = appearance
        self.utils = utils
        DAIHYProviderKey.currentValue = self
    }
    
}

/// Returns the current value for the `StreamChat` instance.
struct DAIHYProviderKey: InjectionKey {
    static var currentValue: DAIHYORDER?
}
