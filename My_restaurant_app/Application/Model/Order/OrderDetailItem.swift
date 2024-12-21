//
//  OrderDetailItem.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 07/05/2024.
//

import UIKit

//struct OrderItem: Codable,Identifiable {
//    
//    var id:Int = 0
//    var order_id:Int = 0
//
//    var food_avatar:String = ""
//    var food_id:Int = 0
//    var name:String = ""
//    var price:Double = 0
//    var quantity:Float = 0
//    var return_quantity_for_drink:Float = 0
//    var printed_quantity:Float = 0
//
//    var total_price:Double = 0
//    var status:FOOD_STATUS = .pending
//    var category_type:FOOD_CATEGORY = .food
//    var is_gift:Int = 0
//    var enable_return_beer:Int = 0
//    var note:String = ""
//    var is_extra_charge:Int = 0
//    var isChange:Bool = false
//
//    var is_sell_by_weight:Int = 0
//    var review_score:Int = 0
//    var is_allow_print_stamp:Int = 0
//    var order_detail_additions:[OrderDetailAddition] = []
//    var order_detail_combo:[OrderDetailAddition] = []
////    var order_detail_promotion_foods:[OrderDetailAddition] = []
////    var order_detail_buffetTicket:[OrderDetailAddition]
//    var buffet_ticket_id:Int?
//    var total_price_include_addition_foods:Float = 0
////
//    var cancel_reason:String = ""
//    var service_start_time:String?
//    var service_end_time:String?
//    var service_time_used:Int?
//    var block_price:Int?
//    var time_per_block:Int?
//    var time_block_price:Int?
//    var is_enable_block:Int?
//    var vat_percent:Float = 0
//    var discount_percent:Int = 0
//    var discount_amount:Int = 0
//    var discount_price:Int = 0
//    var is_only_use_printer:Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case order_id
//        case food_avatar
//        case food_id
//        case name
//        case price
//        case quantity
//        case return_quantity_for_drink
//        case printed_quantity
//        case total_price
//        case status
//        case category_type
//        case is_gift
//        case enable_return_beer
//        case note
//        case is_extra_charge
//
//        case is_sell_by_weight
//        case review_score
//        case is_allow_print_stamp
//        case order_detail_additions
//        case order_detail_combo
//
//        case buffet_ticket_id = "order_buffet_ticket_id"
//        case total_price_include_addition_foods
//
//        case cancel_reason
//        case service_start_time
//        case service_end_time
//        case service_time_used
//        case block_price
//        case time_per_block
//        case time_block_price
//        case is_enable_block
//        case vat_percent
//        case discount_percent
//        case discount_amount
//        case discount_price
//        case is_only_use_printer
//        
//    }
//    
//    init(){
//        
//    }
//
//
//
//
//    
//    mutating func setQuantity(quantity:Float) -> Void {
//        let maximumNumber:Float = self.is_sell_by_weight == ACTIVE ? 200 : 1000
//        
//        if self.is_gift == DEACTIVE{
//       
//            self.quantity = quantity
//          
//            self.quantity = self.quantity >= maximumNumber ? maximumNumber : self.quantity
//            
//            self.isChange = true
//            
//            self.quantity = self.quantity <= 0 ? 0 : self.quantity
//        }
// 
//    }
//    
////    
////    
////    mutating func increaseChildrenItemByOne(id:Int) -> Void {
////        switch category_type {
////            case .buffet_ticket:
////                if let position = order_detail_buffetTicket.firstIndex(where:{$0.id == id}){
////                    order_detail_buffetTicket[position].increaseByOne()
////                    self.isChange = ACTIVE
////                }
////            
////            default:
////                if let position = order_detail_additions.firstIndex(where:{$0.id == id}){
////                    order_detail_additions[position].increaseByOne()
////                    self.isChange = ACTIVE
////                }
////        }
////       
////    }
////
////    
////    mutating func decreaseChildrenItemByOne(id:Int) -> Void {
////        
////        switch category_type {
////            case .buffet_ticket:
////                if let position = order_detail_buffetTicket.firstIndex(where:{$0.id == id}){
////                    order_detail_buffetTicket[position].decreaseByOne()
////                    self.isChange = ACTIVE
////                }
////            
////            
////            default:
////                if let position = order_detail_additions.firstIndex(where:{$0.id == id}){
////                    order_detail_additions[position].decreaseByOne()
////                    self.isChange = ACTIVE
////                }
////            
////        }
////        
////    }
////    
//    
//}
//
//struct OrderDetailAddition: Codable,Hashable {
//    
//    var id:Int
//    var name:String
//    var price:Int
//    var total_price:Int
//    var quantity:Float
////    var rateInfo = ReviewFoodData()
//    var vat_percent:Int
////    var discountAmount:Int
////    var discountPercent:Int
////    var discountPrice:Int
////    var isSelected:Int = DEACTIVE
//    var isChange:Int = DEACTIVE
//    
//
////    init(id:Int,name:String,quantity:Float,price:Int,total_price:Int,discountAmount:Int = 0,discountPercent:Int = 0, discountPrice:Int = 0){
////        self.id = id
////        self.name = name
////        self.quantity = quantity
////        self.price = price
////        self.total_price = total_price
//////        self.discountAmount = discountAmount
//////        self.discountPercent = discountPercent
//////        self.discountPrice = discountPrice
////    }
////    
//    
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case price
//        case total_price
//        case quantity
//        case vat_percent
//        
//    }
//    
//    
//    mutating func increaseByOne() -> Void {
//
//        let maximumNumber:Float = 1000
//       
//        if self.quantity != maximumNumber{
//            self.quantity += 1
//            self.isChange = ACTIVE
//        }
//    }
//
//    
//     mutating func decreaseByOne() -> Void {
//        if self.quantity != 0{
//            self.quantity -= 1
//            self.isChange = ACTIVE
//        }
//        self.quantity = self.quantity <= 0 ? 0 : self.quantity
//    }
//}
//



struct OrderItem: Codable,Identifiable {
    
    var id:Int = 0
    var order_id:Int = 0
    var food_id:Int = 0
    var avatar:String = ""
    var name:String = ""
    var price:Double = 0
    var quantity:Float = 0
    var status:FOOD_STATUS = .pending
    var category_type:CATEGORY_TYPE = .food
    
    var is_gift:Bool = false
    var allow_return:Bool = false
    var note:String = ""
    var is_extra_charge:Bool = false
    var isChange:Bool = false

    var sell_by_weight:Bool = false
    var review_score:Int = 0
    var is_allow_print_stamp:Bool = false
    var order_detail_additions:[OrderDetailAddition] = []
    var order_detail_combo:[OrderDetailAddition] = []
    var children:[ChildrenItem] = []
    var buffet_ticket_id:Int?


    var cancel_reason:String = ""
    var service_start_time:String?
    var service_end_time:String?
    var service_time_used:Int?
    var block_price:Int?
    var time_per_block:Int?
    var time_block_price:Int?
    var is_enable_block:Int?

    var discount_percent:Int = 0
    var discount_amount:Int = 0
    var discount_price:Int = 0
    var is_only_use_printer:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case order_id
        case avatar
        case food_id
        case name
        case price
        case quantity


        case status
        case category_type
        case is_gift
        case allow_return
        case note
        case is_extra_charge

        case sell_by_weight
        case review_score
        case is_allow_print_stamp
        case order_detail_additions
        case order_detail_combo
        case children

        case buffet_ticket_id = "order_buffet_ticket_id"

        case cancel_reason
        case service_start_time
        case service_end_time
        case service_time_used
        case block_price
        case time_per_block
        case time_block_price
        case is_enable_block

        case discount_percent
        case discount_amount
        case discount_price
        case is_only_use_printer
        
    }
    
    init(){
        
    }
    
    mutating func setQuantity(quantity:Float) -> Void {
        let maximumNumber:Float = self.sell_by_weight ? 200 : 1000
        
        if !self.is_gift  {
       
            self.quantity = quantity
          
            self.quantity = self.quantity >= maximumNumber ? maximumNumber : self.quantity
            
            self.isChange = true
            
            self.quantity = self.quantity <= 0 ? 0 : self.quantity
        }
 
    }
    
//
//
//    mutating func increaseChildrenItemByOne(id:Int) -> Void {
//        switch category_type {
//            case .buffet_ticket:
//                if let position = order_detail_buffetTicket.firstIndex(where:{$0.id == id}){
//                    order_detail_buffetTicket[position].increaseByOne()
//                    self.isChange = ACTIVE
//                }
//
//            default:
//                if let position = order_detail_additions.firstIndex(where:{$0.id == id}){
//                    order_detail_additions[position].increaseByOne()
//                    self.isChange = ACTIVE
//                }
//        }
//
//    }
//
//
//    mutating func decreaseChildrenItemByOne(id:Int) -> Void {
//
//        switch category_type {
//            case .buffet_ticket:
//                if let position = order_detail_buffetTicket.firstIndex(where:{$0.id == id}){
//                    order_detail_buffetTicket[position].decreaseByOne()
//                    self.isChange = ACTIVE
//                }
//
//
//            default:
//                if let position = order_detail_additions.firstIndex(where:{$0.id == id}){
//                    order_detail_additions[position].decreaseByOne()
//                    self.isChange = ACTIVE
//                }
//
//        }
//
//    }
//
    
}

extension OrderItem {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        order_id = try container.decodeIfPresent(Int.self, forKey: .order_id) ?? 0
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 150000
        quantity = try container.decodeIfPresent(Float.self, forKey: .quantity) ?? 0
        status = try container.decodeIfPresent(FOOD_STATUS.self, forKey: .status) ?? .pending
        category_type = try container.decodeIfPresent(CATEGORY_TYPE.self, forKey: .category_type) ?? .food
        is_gift = try container.decodeIfPresent(Bool.self, forKey: .is_gift) ?? false
        allow_return = try container.decodeIfPresent(Bool.self, forKey: .allow_return) ?? true
        note = try container.decodeIfPresent(String.self, forKey: .note) ?? ""
        is_extra_charge = try container.decodeIfPresent(Bool.self, forKey: .is_extra_charge) ?? false
        sell_by_weight = try container.decodeIfPresent(Bool.self, forKey: .sell_by_weight) ?? false
        review_score = try container.decodeIfPresent(Int.self, forKey: .review_score) ?? 0
        is_allow_print_stamp = try container.decodeIfPresent(Bool.self, forKey: .is_allow_print_stamp) ?? false
//        order_detail_additions = try container.decodeIfPresent([OrderDetailAddition].self, forKey: .order_detail_additions) ?? []
//        order_detail_combo = try container.decodeIfPresent([OrderDetailAddition].self, forKey: .order_detail_combo) ?? []
        children = try container.decodeIfPresent([ChildrenItem].self, forKey: .children) ?? []
    
        discount_percent = try container.decodeIfPresent(Int.self, forKey: .discount_percent) ?? 0
        discount_amount = try container.decodeIfPresent(Int.self, forKey: .discount_amount) ?? 0
        discount_price = try container.decodeIfPresent(Int.self, forKey: .discount_price) ?? 0
    }
    
}




struct OrderDetailAddition: Codable,Hashable {
    
    var id:Int
    var name:String
    var price:Int
    var total_price:Int
    var quantity:Float
//    var rateInfo = ReviewFoodData()
    var vat_percent:Int
//    var discountAmount:Int
//    var discountPercent:Int
//    var discountPrice:Int
//    var isSelected:Int = DEACTIVE
    var isChange:Int = DEACTIVE
    

//    init(id:Int,name:String,quantity:Float,price:Int,total_price:Int,discountAmount:Int = 0,discountPercent:Int = 0, discountPrice:Int = 0){
//        self.id = id
//        self.name = name
//        self.quantity = quantity
//        self.price = price
//        self.total_price = total_price
////        self.discountAmount = discountAmount
////        self.discountPercent = discountPercent
////        self.discountPrice = discountPrice
//    }
//
    

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case total_price
        case quantity
        case vat_percent
        
    }
    
    
    mutating func increaseByOne() -> Void {

        let maximumNumber:Float = 1000
       
        if self.quantity != maximumNumber{
            self.quantity += 1
            self.isChange = ACTIVE
        }
    }

    
     mutating func decreaseByOne() -> Void {
        if self.quantity != 0{
            self.quantity -= 1
            self.isChange = ACTIVE
        }
        self.quantity = self.quantity <= 0 ? 0 : self.quantity
    }
}


