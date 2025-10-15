//
//  FoodRequest.swift
//  TechresOrder
//
//  Created by Kelvin on 17/01/2023.
//

import UIKit


struct FoodRequest {
    var id = 0
    var quantity:Float = 0
    var price: Int = 0
    var note = ""
    var is_use_point = 0
    var discount_percent = 0
    var customer_order_detail_id = 0
    var addition_foods:[FoodAddition] = []
    var buy_one_get_one_foods:[FoodAddition] = []
    var food_option_foods: [[String: Any]] = []
}
