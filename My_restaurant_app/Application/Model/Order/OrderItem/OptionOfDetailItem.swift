//
//  OptionOfDetailItem.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 14/8/25.
//

import Foundation


struct OptionOfDetailItem: Codable,Identifiable {
    var id = 0
    var name = ""
    var max_items_allowed = 0
    var min_items_allowed = 0
    var food_option_foods:[OptionItem] = []
   
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case max_items_allowed
        case min_items_allowed
        case food_option_foods
    }
    
  
}


struct OptionItem: Codable,Identifiable {
    var id = 0
    var food_id = 0
    var food_name = ""
    var price = 0
    var status = DEACTIVE
    var quantity:Float = 0
   
    
    enum CodingKeys: String, CodingKey {
        case id
        case food_id
        case food_name
        case price
        case status
        case quantity
    }

    
}
