//
//  RevenueCategoryData.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 11/10/25.
//

import SwiftUI

struct RevenueCategoryReport: Codable {
    var reportType = 0
    var dateString = ""
    var fromDate = ""
    var toDate = ""
    var data: [RevenueCategory] = []
    var total_amount = 0

    init() {}

    
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
        case total_amount

    }
    
    
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.data = try container.decodeIfPresent([RevenueCategory].self, forKey: .data) ?? []
       self.total_amount = try container.decodeIfPresent(Int.self, forKey: .total_amount) ?? 0

   }

    
    
}



struct RevenueCategory:Codable {
    
    var category_id = 0
    var category_name = ""
    var total_amount =  0
    var total_original_amount = 0
    var profit = 0
    var order_quantity = 0
    var color:Color? = nil
    
    
    enum CodingKeys: String, CodingKey {
        case category_id
        case category_name
        case total_amount
        case total_original_amount
        case profit
        case order_quantity
    }

      init() {}

      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)

          self.category_id = try container.decodeIfPresent(Int.self, forKey: .category_id) ?? 0
          self.category_name = try container.decodeIfPresent(String.self, forKey: .category_name) ?? ""
          self.total_amount = try container.decodeIfPresent(Int.self, forKey: .total_amount) ?? 0
          self.total_original_amount = try container.decodeIfPresent(Int.self, forKey: .total_original_amount) ?? 0
          self.profit = try container.decodeIfPresent(Int.self, forKey: .profit) ?? 0
          self.order_quantity = try container.decodeIfPresent(Int.self, forKey: .order_quantity) ?? 0
      }
  
    
}
