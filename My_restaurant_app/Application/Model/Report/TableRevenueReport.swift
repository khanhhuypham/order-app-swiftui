//
//  TableRevenueReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 10/10/25.
//


//
//  TableRevenueReport.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 29/08/2023.
//

import SwiftUI

struct TableRevenueReport:Codable{
    var reportType = 0
    var dateString = ""
    var fromDate = ""
    var toDate = ""
    var data = [TableRevenueReportData]()
    var total_revenue = 0
    
  
    
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
    
    enum CodingKeys: String, CodingKey {
   
       case data = "list"
       case total_revenue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([TableRevenueReportData].self, forKey: .data) ?? []
        total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
    }

    

}

struct TableRevenueReportData:Codable{
    var table_id = 0
    var table_name = ""
    var area_id = 0
    var area_name = ""
    var order_count = 0
    var revenue = 0
    var color:Color? = nil

    enum CodingKeys: String, CodingKey {
       case table_id
       case table_name
       case area_id
       case area_name
       case order_count
       case revenue
    }

    init() {}

    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       table_id = try container.decodeIfPresent(Int.self, forKey: .table_id) ?? 0
       table_name = try container.decodeIfPresent(String.self, forKey: .table_name) ?? ""
       area_id = try container.decodeIfPresent(Int.self, forKey: .area_id) ?? 0
       area_name = try container.decodeIfPresent(String.self, forKey: .area_name) ?? ""
       order_count = try container.decodeIfPresent(Int.self, forKey: .order_count) ?? 0
       revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0
    }
    

    
}
