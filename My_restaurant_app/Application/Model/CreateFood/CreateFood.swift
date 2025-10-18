//
//  CreateFood.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 18/10/25.
//


//
//  CreateFoodRequest.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 03/02/2023.
//


struct CreateFood: Codable,Identifiable {
    var id =  0
    var name = ""
    var avatar = ""
    var avatar_thump = ""
    var category_name = ""
    var price:Double = 0
    var originalPrice:Float = 0
    var timeToCompleted = 0
    var is_bbq = 0
    var is_addition = 0
    var is_addition_like_food = 0
    var quantity :Float = 1
    var category_id = 0
    var category_type = 0
    var unit_type = ""
    var code = ""
    var prefix = ""
    var status = 0
    var is_sell_by_weight = 0
    var description = ""
    var allow_print_stamp:Bool = false
    var is_take_away = 0
    var categories = [Category]()
    var food_addition_ids = [Int]()
    var food_material_type = 1
    var printer_id = 0
    var collapsed: Bool! = true
    var temporary_price:Int = 0
    var temporary_percent:Int = 0
    var temporary_price_from_date = ""
    var temporary_price_to_date = ""
    var promotion_percent:Float = 0
    var promotion_from_date = ""
    var promotion_to_date = ""
    var vat_id = 0
    
    init() {}
    
  
    init(food:Food){
        self.id = food.id
        self.name = food.name
        self.category_id = food.category_id
        self.category_type = food.category_type.rawValue
        self.printer_id = food.restaurant_kitchen_place_id
        self.unit_type = food.unit_type
//        self.temporary_price = food.temporary_price
//        self.temporary_percent = food.temporary_percent
        self.price = food.price
        self.avatar = food.avatar
        self.allow_print_stamp = food.is_allow_print_stamp == ACTIVE 
//        self.temporary_price_from_date = food.temporary_price_from_date
//        self.temporary_price_to_date = food.temporary_price_to_date
        self.is_addition = food.is_addition
//        self.is_addition_like_food = food.is_addition_like_food // cho vào menu
        self.food_addition_ids = food.addition_foods.map{$0.id}
        self.is_sell_by_weight = food.is_sell_by_weight
        self.vat_id = food.restaurant_vat_config_id
        self.status = food.status
    }
 

}
