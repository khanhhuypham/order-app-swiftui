//
//  AreaRevenueReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 8/10/25.
//

import SwiftUI

struct AreaRevenueReport:Codable{
    var reportType = 0
    var dateString = ""
    var fromDate = ""
    var toDate = ""
    var data = [AreaRevenueReportData]()
    var total_revenue_amount = 0

    
    init(reportType:Int, dateString:String){
        self.reportType = reportType
        self.dateString = dateString
    }
    
    init(reportType:Int, dateString:String,fromDate:String,toDate:String){
        self.reportType = reportType
        self.dateString = dateString
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case data = "list"
        case total_revenue_amount
    }

    // MARK: - Custom Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([AreaRevenueReportData].self, forKey: .data) ?? []
        total_revenue_amount = try container.decodeIfPresent(Int.self, forKey: .total_revenue_amount) ?? 0
    }

}

struct AreaRevenueReportData:Codable{
    var area_id = 0
    var area_name = ""
    var order_count = 0
    var revenue = 0
    var color:Color? = nil
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
       case area_id
       case area_name
       case order_count
       case revenue
    }

    // MARK: - Custom Decoder
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       area_id = try container.decodeIfPresent(Int.self, forKey: .area_id) ?? 0
       area_name = try container.decodeIfPresent(String.self, forKey: .area_name) ?? ""
       order_count = try container.decodeIfPresent(Int.self, forKey: .order_count) ?? 0
       revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0
    }

}
