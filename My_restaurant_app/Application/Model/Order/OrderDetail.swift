//
//  OrderDetail.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 14/01/2023.
//




struct OrderDetail: Codable {
    var id:Int = 0
    var area_id:Int = 0
    var table_id:Int = 0
    var table_name:String = ""
    var net_amount:Double = 0
    var amount:Double = 0
    var status:OrderStatus = .cancel
    var orderItems:[OrderItem] = []
    var booking_status:BookingStatus?
    var buffet:Buffet?{
        didSet{
           
            guard let buffet = self.buffet, buffet.id != 0 else {
                buffet = nil
                return
            }
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case id
        case area_id
        case table_id
        case table_name
        case status
        case amount
        case net_amount
        case orderItems = "items"
        case booking_status = "booking_status"
        case buffet = "order_buffet_ticket"


    }
   
    init(order:Order) {
        self.id = order.id
//        self.area_id = order.area_id
        self.table_id = order.table_id
        self.table_name = order.table_name
        self.status = order.order_status
        self.net_amount = order.net_amount
    }
    
    init(table:Table) {
        self.id = table.order?.id ?? 0
        self.table_name = table.name ?? ""
        self.table_id = table.id ?? 0
        self.area_id = table.area_id ?? 0
    }

   
    
    init() {}
    
}

extension OrderDetail {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        table_name = try container.decodeIfPresent(String.self, forKey: .table_name) ?? ""
        table_id = try container.decodeIfPresent(Int.self, forKey: .table_id) ?? 0
        status = try container.decodeIfPresent(OrderStatus.self, forKey: .status) ?? .open
        amount = try container.decodeIfPresent(Double.self, forKey: .amount) ?? 0
        net_amount = try container.decodeIfPresent(Double.self, forKey: .net_amount) ?? 0
        
        orderItems = try container.decodeIfPresent([OrderItem].self, forKey: .orderItems) ?? []
       
    }
    
   

}



