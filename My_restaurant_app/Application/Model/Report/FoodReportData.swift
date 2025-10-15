//
//  FoodReportData.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 10/10/25.
//


struct FoodRevenueReport: Codable {
    var reportType:Int = 0
    var dateString = ""
    var fromDate = ""
    var toDate = ""
    var data:[FoodRevenueReportData] = []
    var total_amount:Double = 0

        
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

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      
        data = try container.decodeIfPresent([FoodRevenueReportData].self, forKey: .data) ?? []
        total_amount = try container.decodeIfPresent(Double.self, forKey: .total_amount) ?? 0
    }
    
}


struct FoodRevenueReportData:Codable{

    var food_name: String = ""
    var quantity: Float = 0
    var total_amount: Int = 0

    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case food_name
        case quantity
        case total_amount

    }

    // MARK: - Initializers
    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        food_name = try container.decodeIfPresent(String.self, forKey: .food_name) ?? ""
        quantity = try container.decodeIfPresent(Float.self, forKey: .quantity) ?? 0
        total_amount = try container.decodeIfPresent(Int.self, forKey: .total_amount) ?? 0

    }
}
