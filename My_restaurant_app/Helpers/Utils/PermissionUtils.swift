//
//  permissionUtils.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 03/05/2024.
//

import UIKit

struct PermissionUtils {
    //======== Role Name ========
    static private let OWNER = "OWNER"
    static private let FOOD_MANAGER = "FOOD_MANAGER"
    static private let GENERAL_MANAGER = "GENERAL_MANAGER"
    static private let CHEF_MANAGER = "CHEF_MANAGER"
    static private let ACCOUNTING_MANAGER = "ACCOUNTING_MANAGER"
    static private let CANCEL_COMPLETED_FOOD = "CANCEL_COMPLETED_FOOD"
    static private let EMPLOYEE_MANAGER = "EMPLOYEE_MANAGER"
    static private let RESTAURANT_MANAGER = "RESTAURANT_MANAGER"
    static private let CASHIER_ACCESS = "CASHIER_ACCESS"
    static private let TICKET_MANAGEMENT = "TICKET_MANAGEMENT"

    static private let DISCOUNT_FOOD = "DISCOUNT_FOOD"
    static private let DISCOUNT_ORDER = "DISCOUNT_ORDER"
    static private let ADD_FOOD_NOT_IN_MENU = "ADD_FOOD_NOT_IN_MENU"
    static private let BRANCH_MANAGER = "BRANCH_MANAGER"
    static private let AREA_TABLE_MANAGER = "AREA_TABLE_MANAGER"
    static private let CANCEL_DRINK = "CANCEL_DRINK"
    static private let NEWS_MANAGER = "NEWS_MANAGER"
    static private let UNREACHABLE_NETWORK = "UNREACHABLE_NETWORK"
    static private let REACHABLE_NETWORK = "REACHABLE_NETWORK"
    static private let ACTION_ON_FOOD_AND_TABLE = "ACTION_ON_FOOD_AND_TABLE"
    static private let ORDER_FOOD = "ORDER_FOOD"
    static private let SHARE_POINT = "SHARE_POINT_IN_BILL"
    static private let VIEW_ALL = "VIEW_ALL"
    static private let REPORT_SYSTEM_ERRORS = "REPORT_SYSTEM_ERRORS"
    
    
    static var GPBH_1:Bool {
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_ONE
        }
    }
 
    static var GPBH_1_o_1:Bool {
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_ONE && ManageCacheObject.getAccountSetting()?.branch_type_option == BRANCH_TYPE_OPTION_ONE
        }
    }
    
    
    static var GPBH_1_o_2:Bool {
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_ONE && ManageCacheObject.getAccountSetting()?.branch_type_option == BRANCH_TYPE_OPTION_TWO
        }
    }
    
    
    static var GPBH_1_o_3:Bool {
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_ONE && ManageCacheObject.getAccountSetting()?.branch_type_option == BRANCH_TYPE_OPTION_THREE
        }
    }
    
    
    static var GPBH_2:Bool {
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_TWO
        }
    }
    
    
    static var GPBH_2_o_1:Bool {
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_TWO && ManageCacheObject.getAccountSetting()?.branch_type_option == BRANCH_TYPE_OPTION_ONE
        }
    }
    
    
    static var GPBH_2_o_2:Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_TWO && ManageCacheObject.getAccountSetting()?.branch_type_option == BRANCH_TYPE_OPTION_TWO
        }
        
    }
    
    
    static var GPBH_2_o_3:Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_TWO && ManageCacheObject.getAccountSetting()?.branch_type_option == BRANCH_TYPE_OPTION_THREE
        }
        
    }
    
    static var GPBH_3:Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.branch_type == BRANCH_TYPE_LEVEL_THREE
        }
        
    }
    
    static var GPQT_1_and_above :Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.service_restaurant_level_id ?? 0 >= GPQT_LEVEL_ONE
        }
        
    }
    
    static var GPQT_2_and_above:Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.service_restaurant_level_id ?? 0 >= GPQT_LEVEL_TWO
        }
        
    }
    
    static var GPQT_3_and_above:Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.service_restaurant_level_id ?? 0 >= GPQT_LEVEL_THREE
        }
        
    }
    
    
    static var GPQT_5_and_above :Bool{
        get{
            return ManageCacheObject.getAccountSetting()?.service_restaurant_level_id ?? 0 >= GPQT_LEVEL_FIVE
        }
    }
    
    
    static var is_enale_buffet:Bool{
        get{
            return Constants.brand.setting?.is_enable_buffet == ACTIVE
        }
    }
    
    
    
}
