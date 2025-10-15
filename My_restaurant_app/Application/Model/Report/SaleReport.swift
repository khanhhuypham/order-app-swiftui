//
//  SaleReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//


struct SaleReport: Codable {
    var reportType: Int = 0
    var dateString: String = ""
    var fromDate: String = ""
    var toDate: String = ""
    var data: [SaleReportData] = []
    var total_revenue: Int = 0
    var total_revenue_without_vat: Int = 0
    var total_vat_amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case fromDate
        case toDate
        case data = "list"
        case total_revenue
        case total_revenue_without_vat
        case total_vat_amount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromDate = try container.decodeIfPresent(String.self, forKey: .fromDate) ?? ""
        toDate = try container.decodeIfPresent(String.self, forKey: .toDate) ?? ""
        data = try container.decodeIfPresent([SaleReportData].self, forKey: .data) ?? []
        total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
        total_revenue_without_vat = try container.decodeIfPresent(Int.self, forKey: .total_revenue_without_vat) ?? 0
        total_vat_amount = try container.decodeIfPresent(Int.self, forKey: .total_vat_amount) ?? 0
    }

    init(reportType: Int, dateString: String, fromDate: String, toDate: String) {
        self.reportType = reportType
        self.dateString = dateString
        self.fromDate = fromDate
        self.toDate = toDate
    }

    init(reportType: Int, dateString: String) {
        self.reportType = reportType
        self.dateString = dateString
    }

    init() {}
}


struct SaleReportData: Codable {
    var branch_id: Int = 0
    var report_time: String = ""
    var restaurant_brand_id: Int = 0
    var restaurant_id: Int = 0
    var total_order: Int = 0
    var total_revenue: Int = 0
    var total_revenue_without_vat: Int = 0
    var total_vat_amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case branch_id
        case report_time
        case restaurant_brand_id
        case restaurant_id
        case total_order
        case total_revenue
        case total_revenue_without_vat
        case total_vat_amount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        branch_id = try container.decodeIfPresent(Int.self, forKey: .branch_id) ?? 0
        report_time = try container.decodeIfPresent(String.self, forKey: .report_time) ?? ""
        restaurant_brand_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_brand_id) ?? 0
        restaurant_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_id) ?? 0
        total_order = try container.decodeIfPresent(Int.self, forKey: .total_order) ?? 0
        total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
        total_revenue_without_vat = try container.decodeIfPresent(Int.self, forKey: .total_revenue_without_vat) ?? 0
        total_vat_amount = try container.decodeIfPresent(Int.self, forKey: .total_vat_amount) ?? 0
    }

    init() {}
}
