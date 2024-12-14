//
//  FoodRequest.swift
//  TechresOrder
//
//  Created by Kelvin on 17/01/2023.
//

import UIKit


struct FoodRequest:Codable {
    var id = 0
    var quantity:Float = 0
    var note = ""
    var discount_percent = 0
    var addition_foods:[FoodAddition] = []
    var buy_one_get_one_foods:[FoodAddition] = []
}
