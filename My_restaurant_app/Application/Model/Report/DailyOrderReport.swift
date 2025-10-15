//
//  DailyOrderReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//


struct DailyOrderReport: Codable {
    var reportType: Int = 0
    var dateString: String = ""
    var cash_amount: Int = 0
    var bank_amount: Int = 0
    var transfer_amount: Int = 0
    var total_amount: Int = 0
    var revenue_paid: Int = 0
    var revenue_serving: Int = 0
    var customer_slot_served: Int = 0
    var customer_slot_serving: Int = 0
    var order_served: Int = 0
    var order_serving: Int = 0
    var deposit_amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case cash_amount
        case bank_amount
        case transfer_amount
        case total_amount
        case revenue_paid
        case revenue_serving
        case customer_slot_served
        case customer_slot_serving
        case order_served
        case order_serving
        case deposit_amount
    }

    // ✅ Custom decoder (optional) if you want to provide default values
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cash_amount = try container.decodeIfPresent(Int.self, forKey: .cash_amount) ?? 0
        bank_amount = try container.decodeIfPresent(Int.self, forKey: .bank_amount) ?? 0
        transfer_amount = try container.decodeIfPresent(Int.self, forKey: .transfer_amount) ?? 0
        total_amount = try container.decodeIfPresent(Int.self, forKey: .total_amount) ?? 0
        revenue_paid = try container.decodeIfPresent(Int.self, forKey: .revenue_paid) ?? 0
        revenue_serving = try container.decodeIfPresent(Int.self, forKey: .revenue_serving) ?? 0
        customer_slot_served = try container.decodeIfPresent(Int.self, forKey: .customer_slot_served) ?? 0
        customer_slot_serving = try container.decodeIfPresent(Int.self, forKey: .customer_slot_serving) ?? 0
        order_served = try container.decodeIfPresent(Int.self, forKey: .order_served) ?? 0
        order_serving = try container.decodeIfPresent(Int.self, forKey: .order_serving) ?? 0
        deposit_amount = try container.decodeIfPresent(Int.self, forKey: .deposit_amount) ?? 0
    }

    // ✅ Default initializer
    init() {}
    
    init(reportType:Int, dateString:String){
        self.reportType = reportType
        self.dateString = dateString
    }
}

