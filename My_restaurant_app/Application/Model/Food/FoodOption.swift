//
//  FoodOption.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 08/07/2025.
//

import Foundation



struct FoodOption:Codable,Identifiable {
    var id:Int = 0
    var name:String = ""
    var max_items_allowed:Int = 0
    var min_items_allowed:Int = 0
    var addition_foods:[FoodAddition] = []


    init(){}

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case max_items_allowed
        case min_items_allowed
        case addition_foods
    }
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        max_items_allowed = try container.decodeIfPresent(Int.self, forKey: .max_items_allowed) ?? 0
        min_items_allowed = try container.decodeIfPresent(Int.self, forKey: .min_items_allowed) ?? 0
        addition_foods = try container.decodeIfPresent([FoodAddition].self, forKey: .addition_foods) ?? []

    }
   

}
