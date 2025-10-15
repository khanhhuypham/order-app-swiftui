//
//  ChildrenItem.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 2/10/25.
//


import UIKit

struct ChildrenItem:Codable,Identifiable {
    
    var id:Int = 0
    var name:String = ""
    var price:Float = 0
    var is_out_stock:Int = 0
    var avatar:String = ""
    var unit_type:String = ""
    var quantity:Float = 0
    var isSelect:Bool = false
    var category_id = 0
    var status:Int = 0
    
    init(){}

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case avatar
        case is_out_stock
        case quantity
        case unit_type
        case category_id
        case status
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
    
    
    mutating func setQuantity(quantity:Float) -> Void {
        self.quantity = quantity
        self.quantity = quantity > 0 ? quantity : 0
        isSelect = quantity > 0 ? true : false
    }
}

extension ChildrenItem {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Float.self, forKey: .price) ?? 0
        quantity = try container.decodeIfPresent(Float.self, forKey: .quantity) ?? 0
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        is_out_stock = try container.decodeIfPresent(Int.self, forKey: .is_out_stock) ?? 0
        unit_type = try container.decodeIfPresent(String.self, forKey: .unit_type) ?? ""
        category_id = try container.decodeIfPresent(Int.self, forKey: .category_id) ?? 0
        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
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
                        "category_id":2,
                        "status":1
                    },
                    {
                        "id": 43462,
                        "name": "toping 2",
                        "price": 20000.0,
                        "avatar": "/public/resource/avatar_default/default.jpg",
                        "unit_type": "Bao",
                        "vat_percent": 0,
                        "is_out_stock": 0,
                        "category_id":2,
                        "status":1
                    }
                ]
        """
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode the JSON into a User instance
                let data = try JSONDecoder().decode([ChildrenItem].self, from: jsonData)
                
                return data
            } catch {
                
    
            }
        }
        
        return []
        
    }
    
}

