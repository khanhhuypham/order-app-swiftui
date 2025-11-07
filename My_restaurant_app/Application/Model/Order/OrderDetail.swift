//
//  OrderDetail.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 14/01/2023.
//




struct OrderDetail: Codable {
    var id:Int = 0
    var id_in_branch = 0
    var area_id:Int = 0
    var table_id:Int = 0
    var table_name:String = ""
    var amount:Double = 0
    var total_amount:Double = 0
    var total_final_amount:Int = 0
    var status:OrderStatus = .cancel
    var order_method:ORDER_METHOD?
    var orderItems:[OrderItem] = []
    var booking_status:BookingStatus?
    var customer_slot_number:Int = 0
    var employee_name: String = ""
    var customer_name: String = ""
    var customer_phone: String = ""
    var shipping_address:String = ""
    var customer_address:String = ""
    var service_charge_amount:Int = 0
    var extra_charge_amount:Int = 0
    var vat_amount:Int = 0
    var created_at:String = ""
    var payment_date:String = ""
    var total_amount_discount_percent = 0
    var total_amount_discount_amount = 0
    var food_discount_amount = 0
    var drink_discount_amount = 0
    var food_discount_percent = 0
    var drink_discount_percent = 0
    
    
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
        case id_in_branch
        case area_id
        case table_id
        case table_name
        case status
        case order_method
        case amount
        case total_amount
        case total_final_amount
        case orderItems = "order_details"
        case booking_status = "booking_status"
        case buffet = "order_buffet_ticket"
        case customer_slot_number
        case customer_phone
        case customer_name
        case employee_name
        case shipping_address
        case customer_address
        case service_charge_amount
        case extra_charge_amount = "total_amount_extra_charge_amount"
        case vat_amount
        case total_amount_discount_percent
        case total_amount_discount_amount
        case food_discount_amount
        case drink_discount_amount
        case food_discount_percent
        case drink_discount_percent
        case created_at
        case payment_date
    }
   
    init(order:Order) {
        self.id = order.id
        self.area_id = order.area_id
        self.table_id = order.table_id
        self.table_name = order.table_name
        self.status = order.order_status
        self.total_amount = order.total_amount
        self.amount = order.total_amount
    }
    
    init(table:Table) {
        self.id = table.order_id ?? 0
        self.table_name = table.name ?? ""
        self.table_id = table.id ?? 0
        self.area_id = table.area_id ?? 0
    }

   
    
    init() {}
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        id_in_branch = try container.decodeIfPresent(Int.self, forKey: .id_in_branch) ?? 0
        area_id = try container.decodeIfPresent(Int.self, forKey: .area_id) ?? 0
        table_id = try container.decodeIfPresent(Int.self, forKey: .table_id) ?? 0
        table_name = try container.decodeIfPresent(String.self, forKey: .table_name) ?? ""
        
        amount = try container.decodeIfPresent(Double.self, forKey: .amount) ?? 0
        total_amount = try container.decodeIfPresent(Double.self, forKey: .total_amount) ?? 0
        total_final_amount = try container.decodeIfPresent(Int.self, forKey: .total_final_amount) ?? 0
        
        status = try container.decodeIfPresent(OrderStatus.self, forKey: .status) ?? .cancel
        order_method = try container.decodeIfPresent(ORDER_METHOD.self, forKey: .order_method)
        
        orderItems = try container.decodeIfPresent([OrderItem].self, forKey: .orderItems) ?? []
        booking_status = try container.decodeIfPresent(BookingStatus.self, forKey: .booking_status)
        
        customer_slot_number = try container.decodeIfPresent(Int.self, forKey: .customer_slot_number) ?? 0
        employee_name = try container.decodeIfPresent(String.self, forKey: .employee_name) ?? ""
        customer_name = try container.decodeIfPresent(String.self, forKey: .customer_name) ?? ""
        customer_phone = try container.decodeIfPresent(String.self, forKey: .customer_phone) ?? ""
        shipping_address = try container.decodeIfPresent(String.self, forKey: .shipping_address) ?? ""
        customer_address = try container.decodeIfPresent(String.self, forKey: .customer_address) ?? ""
        
        service_charge_amount = try container.decodeIfPresent(Int.self, forKey: .service_charge_amount) ?? 0
        extra_charge_amount = try container.decodeIfPresent(Int.self, forKey: .extra_charge_amount) ?? 0
        vat_amount = try container.decodeIfPresent(Int.self, forKey: .vat_amount) ?? 0
        
        total_amount_discount_percent = try container.decodeIfPresent(Int.self, forKey: .total_amount_discount_percent) ?? 0
        total_amount_discount_amount = try container.decodeIfPresent(Int.self, forKey: .total_amount_discount_amount) ?? 0
        food_discount_amount = try container.decodeIfPresent(Int.self, forKey: .food_discount_amount) ?? 0
        drink_discount_amount = try container.decodeIfPresent(Int.self, forKey: .drink_discount_amount) ?? 0
        food_discount_percent = try container.decodeIfPresent(Int.self, forKey: .food_discount_percent) ?? 0
        drink_discount_percent = try container.decodeIfPresent(Int.self, forKey: .drink_discount_percent) ?? 0
        
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        payment_date = try container.decodeIfPresent(String.self, forKey: .payment_date) ?? ""
        
        buffet = try container.decodeIfPresent(Buffet.self, forKey: .buffet)
        
        // Optional: clear buffet if invalid
        if let b = buffet, b.id == 0 {
            buffet = nil
        }
    }

    
}




struct NewOrder:Codable {
    var order_id = 0
    
    init(order_id:Int) {
        self.order_id = order_id
    }
    
    
    enum CodingKeys: String, CodingKey {
        case order_id
     
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try container.decodeIfPresent(Int.self, forKey: .order_id) ?? 0
   
    }
}





//
//struct VATInfor: Mappable {
//    var vat_amount = 0
//    var vat_percent = 0
//    init?(map: Map) {}
//    mutating func mapping(map: Map) {
//        vat_amount      <- map["vat_amount"]
//        vat_percent     <- map["vat_percent"]
//    }
//}
