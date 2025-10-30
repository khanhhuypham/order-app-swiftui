//
//  OrderNeedToPrint.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 19/01/2024.
//



struct PrintItem:Codable,Identifiable {
    
    var id = 0
    var name =  ""
    var status:ORDER_ITEM_STATUS = .pending
    var childrenItem:[childrenItem] = [] //Biến này chỉ dùng để map các món con khi gọi api lấy danh sách các món cần in
    var printer_id = 0
    var return_quantity_for_drink = 0
    var order_id = 0
    var discount_percent = 0
    var buffet_ticket_ids:[Int]? = nil
    var is_booking_item:Int = DEACTIVE
    var category_type:FOOD_CATEGORY = .food
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case childrenItem = "order_detail_additions"
        case printer_id = "restaurant_kitchen_place_id"
        case return_quantity_for_drink
        case order_id
        case discount_percent
        case buffet_ticket_ids
        case category_type
    }
    
}

struct childrenItem:Codable {
    var id = 0
    var name =  ""
    var quantity:Float = 0
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
    }
    
}
