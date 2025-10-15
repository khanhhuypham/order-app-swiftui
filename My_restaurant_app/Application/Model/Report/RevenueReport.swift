//
//  RevenueReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//



struct RevenueReport: Codable {
    var reportType = 0
    var dateString = ""
    var revenues: [Revenue] = []
    var total_revenue = 0
    enum CodingKeys: String, CodingKey {
        case revenues
        case total_revenue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        revenues = try container.decodeIfPresent([Revenue].self, forKey: .revenues) ?? []
        total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
    }

    init(reportType:Int, dateString:String){
        self.reportType = reportType
        self.dateString = dateString
    }
 
}


struct Revenue: Codable {
    var report_time: String = ""
    var restaurant_id: Int = 0
    var restaurant_brand_id: Int = 0
    var branch_id: Int = 0
    var total_revenue: Int = 0
    var total_order: Int = 0

    enum CodingKeys: String, CodingKey {
        case report_time
        case restaurant_id
        case restaurant_brand_id
        case branch_id
        case total_revenue
        case total_order
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        report_time = try container.decodeIfPresent(String.self, forKey: .report_time) ?? ""
        restaurant_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_id) ?? 0
        restaurant_brand_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_brand_id) ?? 0
        branch_id = try container.decodeIfPresent(Int.self, forKey: .branch_id) ?? 0
        total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
        total_order = try container.decodeIfPresent(Int.self, forKey: .total_order) ?? 0
    }

    init() {}
}
