//
//  AccountSetting.swift
//  SwiftUI-Demo
//
//  Created by Pham Khanh Huy on 12/09/2024.
//

import UIKit


struct AccountSetting: Codable {
    var is_enable_checkin:Int = 0
    var service_restaurant_level_id:Int = 0
    var service_restaurant_level_type:Int = 0
    var branch_type:Int = 0
    var branch_type_option:Int = 0
    var hour_to_take_report:Int = 0
    var is_allow_print_temporary_bill:Int = 0
    var is_hide_total_amount_before_complete_bill:Int = 0
    var is_have_take_away:Int = 0
    var branch:Branch = Branch()
    

    private enum CodingKeys: String, CodingKey {
      case is_enable_checkin
      case service_restaurant_level_id = "service_restaurant_level_id"
      case service_restaurant_level_type = "service_restaurant_level_type"
      case branch_type = "branch_type"
      case branch_type_option = "branch_type_option"
      case hour_to_take_report
      case is_allow_print_temporary_bill
      case is_hide_total_amount_before_complete_bill
      case is_have_take_away
      case branch = "branch_info"
    }
    
    
}

