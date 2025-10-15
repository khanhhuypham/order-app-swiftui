//
//  OrderNeedToPrint.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 19/01/2024.
//

import Foundation

struct OrderItemUpdate:Codable {
    var order_detail_id = 0
    var quantity: Float = 0
    var price: Int = 0
    var note = ""
    var discount_percent = 0
    var order_detail_food_options:[OptionUpdate] = []
    
    
    enum CodingKeys: String, CodingKey {
        case order_detail_id
        case quantity
        case price
        case note
        case discount_percent
        case order_detail_food_options
    }
}



struct OptionUpdate: Codable {
    var food_option_id = 0
    var order_detail_food_option_id = 0
    var status = DEACTIVE
    var quantity: Float = 0
    
  
    init(food_option_id:Int,id:Int,quantity:Float,status:Int){
        self.food_option_id = food_option_id
        self.order_detail_food_option_id = id
        self.status = status
        self.quantity = quantity
    }
    
    enum CodingKeys: String, CodingKey {
        case food_option_id
        case order_detail_food_option_id
        case status
        case quantity
    }
    


}
