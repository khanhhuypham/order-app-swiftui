//
//  FoodAddition.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 06/01/2024.
//

import UIKit

struct FoodAddition:Codable,Identifiable {
    var id:Int = 0
    var name:String = ""
    var price:Float = 0
    var avatar:String = ""
    var is_out_stock:Int = 0
    var price_with_temporary:Int = 0
    var unit_type:String = ""
    var quantity = 0
    var combo_quantity = 0
    var isSelect:Bool = false
 
    
    init(){}

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case avatar
        case is_out_stock
        case price_with_temporary
        case quantity
        case combo_quantity
        case unit_type
    }
    
    
    
   
    
    mutating func select() -> Void {
        isSelect = true
        if quantity <= 0 && isSelect {
            quantity = 1
        }
    }
    
    
    mutating func deSelect() -> Void {
        isSelect = false
        
         if isSelect == false{
            quantity = 0
        }
    }
    
    
    mutating func setQuantity(quantity:Int) -> Void {
        self.quantity = quantity
        self.quantity = quantity > 0 ? quantity : 0
        isSelect = quantity > 0 ? true : false
    }
}

extension FoodAddition {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Float.self, forKey: .price) ?? 0
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        is_out_stock = try container.decodeIfPresent(Int.self, forKey: .is_out_stock) ?? 0
        price_with_temporary = try container.decodeIfPresent(Int.self, forKey: .price_with_temporary) ?? 0
        unit_type = try container.decodeIfPresent(String.self, forKey: .unit_type) ?? ""
        combo_quantity = try container.decodeIfPresent(Int.self, forKey: .combo_quantity) ?? 0
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
    }
    
    
    
    static func getDummyData() -> [Self]{
        let jsonString = """
                [
                    {
                        "id": 43461,
                        "name": "topping 1",
                        "price": 12000.0,
                        "avatar": "4i4eXF3Vcwf0Kd65duotC",
                        "unit_type": "Bao",
                        "vat_percent": 0,
                        "is_out_stock": 0,
                        "temporary_price": 0,
                        "price_with_temporary": 12000.0
                    },
                    {
                        "id": 43462,
                        "name": "toping 2",
                        "price": 20000.0,
                        "avatar": "/public/resource/avatar_default/default.jpg",
                        "unit_type": "Bao",
                        "vat_percent": 0,
                        "is_out_stock": 0,
                        "temporary_price": 0,
                        "price_with_temporary": 20000.0
                    }
                ]
        """
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode the JSON into a User instance
                let data = try JSONDecoder().decode([FoodAddition].self, from: jsonData)
                
                return data
            } catch {
                
    
            }
        }
        
        return []
        
    }
    
}




