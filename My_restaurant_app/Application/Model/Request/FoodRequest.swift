//
//  FoodRequest.swift
//  TechresOrder
//
//  Created by Kelvin on 17/01/2023.
//

import UIKit


struct FoodRequest:Codable,Identifiable {
    var id = 0
    var quantity:Float = 0
    var note = ""
    var discount_percent:Int?
    var children:[FoodRequestChild] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case quantity
        case note
        case discount_percent
        case children
    }
}
// Define a separate structure for children if needed
struct FoodRequestChild: Codable {
    let id: Int
    let quantity: Float
    init(id: Int, quantity: Float) {
        self.id = id
        self.quantity = quantity
    }
}
