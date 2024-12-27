//
//  Food.swift
//  TechresOrder
//
//  Created by Kelvin on 16/01/2023.
//

import UIKit

struct FoodResponse: Codable {
    var total_record:Int
    var limit:Int
    var list:[Food]
        
    enum CodingKeys: String, CodingKey {
        case total_record
        case limit
        case list
    }
}

struct Food:Identifiable {

    var id:Int = 0
    var status:Int = 0
    var name:String =  ""
    var note:String = ""
    var price:Double =  0
    var unit_id:Int = 0
    var unit_type:String = ""
    var quantity:Float = 0.0
    var category_id:Int = 0
    var avatar:String = ""
    var temporary_price:Double = 0
    var sell_by_weight:Bool = false
    var category_type:CATEGORY_TYPE = .food
    var printer_id:Int = 0
//    var food_in_combo:[FoodAddition] = []
//    var addition_foods:[FoodAddition] = []
//    var order_detail_additions = [OrderDetailAddition]() //Biến này chỉ dùng để map các món con khi gọi api lấy danh sách các món cần in
//    var food_list_in_promotion_buy_one_get_one:[FoodAddition] = []
    var children:[ChildrenItem] = []
    var is_allow_print_stamp:Int = 0
    var out_of_stock:Bool = false
    var isSelect:Bool = false
    var buffet_ticket_ids:[Int]? = nil
    var discount_percent:Int = 0
    var description:String = ""
    var is_gift:Bool = false
    


    
    init(id:Int,name:String){
        self.id = id
        self.name = name
    }
    
    init(){}
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case name
        case price
        case unit_id
        case unit_type
        case category_id
        case avatar
        case temporary_price
        case sell_by_weight
        case category_type
        case printer_id
//        case food_in_combo
//        case addition_foods
//        case food_list_in_promotion_buy_one_get_one
        case is_allow_print_stamp
        case out_of_stock
        case buffet_ticket_ids = "buffet_ticket_ids"
        case children
        case description

    }
    
    
    
    
    static func getDummyData() -> Self?{
        var jsonString = """
            {
             "image": null,
             "out_of_stock": false,
             "category_name": "French",
             "description": "Classic French dish featuring chicken braised in red wine with mushrooms and onions.",
             "unit_type": "Each",
             "sell_by_weight": false,
             "category_id": 7,
             "children": [
                 {
                     "image": null,
                     "category_id": 2,
                     "price": 4.99,
                     "name": "Garlic Bread",
                     "description": null,
                     "id": 3,
                     "unit_type": "Each"
                 },
                 {
                     "image": null,
                     "category_id": 2,
                     "price": 5.99,
                     "name": "Breadsticks",
                     "description": null,
                     "id": 4,
                     "unit_type": "Each"
                 }
             ],
             "price": 14.99,
             "name": "Coq au Vin",
             "printer_id": 1,
             "id": 3,
             "unit_id": 1
         }
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode the JSON into a User instance
                let data = try JSONDecoder().decode(Food.self, from: jsonData)
                
                return data
            } catch {
                
                dLog("Lỗi parse dữ liệu Food")
                return nil
            }
        }
    
        return nil
    }
}

extension Food: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        temporary_price = try container.decodeIfPresent(Double.self, forKey: .temporary_price) ?? 0
        unit_id = try container.decodeIfPresent(Int.self, forKey: .unit_id) ?? 0
        unit_type = try container.decodeIfPresent(String.self, forKey: .unit_type) ?? ""
        category_id = try container.decodeIfPresent(Int.self, forKey: .category_id) ?? 0
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        sell_by_weight = try container.decodeIfPresent(Bool.self, forKey: .sell_by_weight) ?? false
        category_type = try container.decodeIfPresent(CATEGORY_TYPE.self, forKey: .category_type) ?? .food
        printer_id = try container.decodeIfPresent(Int.self, forKey: .printer_id) ?? 0
//        food_in_combo = try container.decodeIfPresent([FoodAddition].self, forKey: .food_in_combo) ?? []
//        addition_foods = try container.decodeIfPresent([FoodAddition].self, forKey: .addition_foods) ?? []
//        food_list_in_promotion_buy_one_get_one = try container.decodeIfPresent([FoodAddition].self, forKey: .food_list_in_promotion_buy_one_get_one) ?? []
        out_of_stock = try container.decodeIfPresent(Bool.self, forKey: .out_of_stock) ?? false
        buffet_ticket_ids = try container.decodeIfPresent([Int].self, forKey: .buffet_ticket_ids) ?? nil
        children = try container.decodeIfPresent([ChildrenItem].self, forKey: .children) ?? []
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
}






extension Food{
    
    
    mutating func select() -> Void {
        isSelect = true
        if quantity <= 0 && isSelect{
            quantity = sell_by_weight ? 0.01 : 1
        }
    }
    
    
    mutating func deSelect() -> Void {
        isSelect = false
        
         if isSelect == false{
            quantity = 0
            discount_percent = 0
            note = ""
//            addition_foods.enumerated().forEach{(i,data) in
//                addition_foods[i].deSelect()
//            }
//             
//            food_list_in_promotion_buy_one_get_one.enumerated().forEach{(i,data) in
//                food_list_in_promotion_buy_one_get_one[i].deSelect()
//            }
            
        }
    }
    
    mutating func setQuantity(quantity:Float) -> Void {

        let maximumNumber:Float = 1000
        self.quantity = quantity
    
        self.quantity = self.quantity >= maximumNumber ? maximumNumber : self.quantity
        
          if self.quantity > 0 {
              self.isSelect = true
//              self.addition_foods.enumerated().forEach{(i,childFood) in
//                  if childFood.isSelect && self.is_allow_print_stamp == ACTIVE{
//                      /*
//                              Nếu món chính là món in stamp
//                                  if món chính bán theo kg -> thì số lượng món con luôn = 1
//                                  if món chính không bán theo kg -> thì số lượng món con luôn = số lượng món chính
//                              các số lượng các món con được check sẽ = với số lượng món chính
//                          */
//                      self.addition_foods[i].quantity = self.sell_by_weight ? Int(1) : Int(self.quantity)
//                  }
//              }
              if self.category_type == .service && self.quantity > 1{
                  self.quantity = 1
              }
          }else{
              self.deSelect()
          }
    }

    
    mutating func getChildren(id:Int) -> FoodAddition? {
//        if addition_foods.count > 0{
//            if let i = addition_foods.firstIndex(where: {$0.id == id}){
//                return addition_foods[i]
//            }
//        }else if food_list_in_promotion_buy_one_get_one.count > 0{
//            
//            if let i = food_list_in_promotion_buy_one_get_one.firstIndex(where: {$0.id == id}){
//               return food_list_in_promotion_buy_one_get_one[i]
//            }
//        }
        return nil
    }
    
    
    mutating func selectChildren(id:Int) -> Void {

//        if !addition_foods.isEmpty{
//            
//            if let i = addition_foods.firstIndex(where: {$0.id == id}){
//                
//                if is_allow_print_stamp == ACTIVE{
//                /*
//                       Nếu món chính là món in stamp
//                       if món chính bán theo kg -> thì số lượng món con luôn = 1
//                       if món chính không bán theo kg -> thì số lượng món con luôn = số lượng món chính
//                       các số lượng các món con được check sẽ = với số lượng món chính
//                    */
//                    addition_foods[i].quantity = sell_by_weight ? Int(1) : Int(quantity)
//                    addition_foods[i].isSelect = true
//                }else {
//                    addition_foods[i].select()
//                }
//            }
//        }else if !food_list_in_promotion_buy_one_get_one.isEmpty{
//            var childrenQuantity = 0
//            
//            for children in food_list_in_promotion_buy_one_get_one{
//                childrenQuantity += children.quantity
//            }
//            
//            if let i = food_list_in_promotion_buy_one_get_one.firstIndex(where: {$0.id == id}){
//                if Float(childrenQuantity) < quantity{
//                    food_list_in_promotion_buy_one_get_one[i].select()
//                }
//
//            }
//        }
    }
 
    mutating func deSelectChildren(id:Int) -> Void {
//        if addition_foods.count > 0{
//            
//            if let i = addition_foods.firstIndex(where: {$0.id == id}){
//                addition_foods[i].deSelect()
//            }
//            
//        }else if food_list_in_promotion_buy_one_get_one.count > 0{
//            
//            if let i = food_list_in_promotion_buy_one_get_one.firstIndex(where: {$0.id == id}){
//                food_list_in_promotion_buy_one_get_one[i].deSelect()
//            }
//        }
    }
    
    
    mutating func setChildrenQuantity(id:Int,quantity:Int) -> Void {
//        if addition_foods.count > 0{
//            if let i = addition_foods.firstIndex(where: {$0.id == id}){
//                addition_foods[i].setQuantity(quantity: quantity)
//            }
//        }else if food_list_in_promotion_buy_one_get_one.count > 0{
//            if let i = food_list_in_promotion_buy_one_get_one.firstIndex(where: {$0.id == id}){
//                food_list_in_promotion_buy_one_get_one[i].setQuantity(quantity: quantity)
//            }
//        }
    }
   
  
}
