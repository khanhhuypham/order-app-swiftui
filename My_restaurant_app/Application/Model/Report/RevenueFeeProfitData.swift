//
//  RevenueFeeProfitData.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//



struct RevenueFeeProfitData: Codable {
    var revenues: [RevenueFeeProfit] = []
    var total_revenue_amount: Int = 0
    var total_cost_amount: Int = 0
    var total_profit_amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case revenues
        case total_revenue_amount
        case total_cost_amount
        case total_profit_amount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        revenues = try container.decodeIfPresent([RevenueFeeProfit].self, forKey: .revenues) ?? []
        total_revenue_amount = try container.decodeIfPresent(Int.self, forKey: .total_revenue_amount) ?? 0
        total_cost_amount = try container.decodeIfPresent(Int.self, forKey: .total_cost_amount) ?? 0
        total_profit_amount = try container.decodeIfPresent(Int.self, forKey: .total_profit_amount) ?? 0
    }

    init() {}
}


struct RevenueFeeProfitReport: Codable {
    var reportType: Int = 0
    var dateString: String = ""
    var fromDate: String = ""
    var data: [RevenueFeeProfit] = []
    var total_revenue_amount: Int = 0
    var total_cost_amount: Int = 0
    var total_profit_amount: Int = 0

    enum CodingKeys: String, CodingKey {
  
        case data = "list"
        case total_revenue_amount
        case total_cost_amount
        case total_profit_amount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        data = try container.decodeIfPresent([RevenueFeeProfit].self, forKey: .data) ?? []
        total_revenue_amount = try container.decodeIfPresent(Int.self, forKey: .total_revenue_amount) ?? 0
        total_cost_amount = try container.decodeIfPresent(Int.self, forKey: .total_cost_amount) ?? 0
        total_profit_amount = try container.decodeIfPresent(Int.self, forKey: .total_profit_amount) ?? 0
    }

    init(reportType: Int, dateString: String, fromDate: String) {
        self.reportType = reportType
        self.dateString = dateString
        self.fromDate = fromDate
    }

    init(reportType: Int, dateString: String) {
        self.reportType = reportType
        self.dateString = dateString
    }

    init() {}
}


struct RevenueFeeProfit: Codable {
    var restaurant_id: Int = 0
    var restaurant_brand_id: Int = 0
    var branch_id: Int = 0
    var branch_name: String = ""
    var total_revenue_amount: Int = 0
    var total_cost_amount: Int = 0
    var total_profit_amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case restaurant_id
        case restaurant_brand_id
        case branch_id
        case branch_name
        case total_revenue_amount
        case total_cost_amount
        case total_profit_amount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        restaurant_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_id) ?? 0
        restaurant_brand_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_brand_id) ?? 0
        branch_id = try container.decodeIfPresent(Int.self, forKey: .branch_id) ?? 0
        branch_name = try container.decodeIfPresent(String.self, forKey: .branch_name) ?? ""
        total_revenue_amount = try container.decodeIfPresent(Int.self, forKey: .total_revenue_amount) ?? 0
        total_cost_amount = try container.decodeIfPresent(Int.self, forKey: .total_cost_amount) ?? 0
        total_profit_amount = try container.decodeIfPresent(Int.self, forKey: .total_profit_amount) ?? 0
    }

    init() {}
}
