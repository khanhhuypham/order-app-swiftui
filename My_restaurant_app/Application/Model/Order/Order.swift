//
//  Order.swift
//  TechresOrder
//
//  Created by Kelvin on 13/01/2023.
//

import UIKit


struct OrderResponse:Decodable{
    var limit: Int?
    var total_record:Int?
    var list: [Order] = []
}


struct Order:Codable,Identifiable {
    var id:Int = 0
    var table_name:String = ""
    var table_id:Int = 0
    var table_merged_names:[String] = []
    var using_slot:Int?
    var order_status:OrderStatus = .open
    var using_time_minutes_string:String = ""
    var total_amount:Double = 0
    var booking_infor_id:Int? = nil
    var buffet_ticket_id:Int? = nil
    var booking_status:BookingStatus? = .none
    var isSelect:Bool = false
    var net_amount:Double = 0
   

    
    enum CodingKeys: String, CodingKey {
        case id
        case table_name
        case table_id
        case table_merged_names
        case using_slot
        case order_status
        case using_time_minutes_string
        case total_amount
        case net_amount
        case booking_infor_id
        case buffet_ticket_id
        case booking_status

        
    }
    
    init() {
       
    }
    
    
    init(table:Table) {
        self.id = table.order_id ?? 0
        self.table_name = table.name ?? ""
        self.table_id = table.id ?? 0
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
        table_name = try container.decodeIfPresent(String.self, forKey: .table_name) ?? ""
        table_id = try container.decodeIfPresent(Int.self, forKey: .table_id) ?? 0
        table_merged_names = try container.decodeIfPresent([String].self, forKey: .table_merged_names) ?? []
        using_slot = try container.decodeIfPresent(Int.self, forKey: .using_slot) ?? 0
        order_status = try container.decodeIfPresent(OrderStatus.self, forKey: .order_status) ?? .open
        using_time_minutes_string = try container.decodeIfPresent(String.self, forKey: .using_time_minutes_string) ?? ""
        total_amount = try container.decodeIfPresent(Double.self, forKey: .total_amount) ?? 0
        net_amount = try container.decodeIfPresent(Double.self, forKey: .net_amount) ?? 0
       
    }
    

}



