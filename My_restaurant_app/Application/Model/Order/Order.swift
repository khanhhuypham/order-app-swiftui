//
//  Order.swift
//  TechresOrder
//
//  Created by Kelvin on 13/01/2023.
//

import UIKit


struct OrderResponse:Codable{
    var limit: Int = 0
    var total_record:Int = 0
    var list:[Order] = []
    enum CodingKeys: String, CodingKey {
        case limit
        case total_record
        case list = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        limit = try container.decodeIfPresent(Int.self, forKey: .limit) ?? 0
        total_record = try container.decodeIfPresent(Int.self, forKey: .total_record) ?? 0
        list = try container.decodeIfPresent([Order].self, forKey: .list) ?? []
    }
    
}



struct Order:Codable,Identifiable,Hashable {
    var id:Int = 0
    var id_in_branch:Int = 0
    var area_id:Int = 0
    var table_id:Int = 0
    var table_name:String = ""
    var table_merge_list_name:[String] = []
    var using_slot:Int = 0
    var order_status:OrderStatus = .open
    var order_method:ORDER_METHOD = .EAT_IN
    var using_time_minutes_string:String = ""
    var total_amount:Double = 0
    var booking_infor_id:Int? = nil
    var buffet_ticket_id:Int? = nil
    var booking_status:BookingStatus?
    var employee:EmployeeCreateOrder?
    var order_detail_pending_quantity = 0
    var payment_date:String?
    var isSelect:Bool = false

    
    enum CodingKeys: String, CodingKey {
        case id
        case id_in_branch
        case area_id
        case table_id
        case table_name
        case table_merge_list_name
        case using_slot
        case order_status
        case order_method
        case using_time_minutes_string
        case total_amount
        case booking_infor_id
        case buffet_ticket_id
        case booking_status
        case employee
        case order_detail_pending_quantity
        case payment_date
    }
    
    init() {
       
    }
    
    
    init(table:Table) {
        self.id = table.order_id ?? 0
        self.table_name = table.name ?? ""
        self.table_id = table.id ?? 0
        self.area_id = table.area_id ?? 0
    }
    
    init(orderDetail:OrderDetail) {
        self.id = orderDetail.id
        self.table_name = orderDetail.table_name
        self.table_id = orderDetail.table_id
//        self.buffet_ticket_id = orderDetail.buffet?.buffet_ticket_id ?? 0
    }
}

extension Order {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        id_in_branch = try container.decodeIfPresent(Int.self, forKey: .id_in_branch) ?? 0
        area_id = try container.decodeIfPresent(Int.self, forKey: .area_id) ?? 0
        table_id = try container.decodeIfPresent(Int.self, forKey: .table_id) ?? 0
        table_name = try container.decodeIfPresent(String.self, forKey: .table_name) ?? ""
        table_merge_list_name = try container.decodeIfPresent([String].self, forKey: .table_merge_list_name) ?? []
        using_slot = try container.decodeIfPresent(Int.self, forKey: .using_slot) ?? 0
        order_status = try container.decodeIfPresent(OrderStatus.self, forKey: .order_status) ?? .open
        order_method = try container.decodeIfPresent(ORDER_METHOD.self, forKey: .order_method) ?? .EAT_IN
        using_time_minutes_string = try container.decodeIfPresent(String.self, forKey: .using_time_minutes_string) ?? ""
        total_amount = try container.decodeIfPresent(Double.self, forKey: .total_amount) ?? 0
        booking_infor_id = try container.decodeIfPresent(Int.self, forKey: .booking_infor_id)
        buffet_ticket_id = try container.decodeIfPresent(Int.self, forKey: .buffet_ticket_id)
        booking_status = try container.decodeIfPresent(BookingStatus.self, forKey: .booking_status)
        employee = try container.decodeIfPresent(EmployeeCreateOrder.self, forKey: .employee) ?? EmployeeCreateOrder()
        order_detail_pending_quantity = try container.decodeIfPresent(Int.self, forKey: .order_detail_pending_quantity) ?? 0
        payment_date = try container.decodeIfPresent(String.self, forKey: .payment_date) ?? ""
   
       
    }
    

}



struct EmployeeCreateOrder:Codable,Identifiable,Hashable {
    var id:Int = 0
    var avatar:String = ""
    var name:String = ""
    var role_name:String = ""
    var user_name:String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case name
        case role_name
        case user_name
    }
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        role_name = try container.decodeIfPresent(String.self, forKey: .role_name) ?? ""
        user_name = try container.decodeIfPresent(String.self, forKey: .user_name) ?? ""
    }

}
