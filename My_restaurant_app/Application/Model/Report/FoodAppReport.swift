//
//  FoodAppReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 7/10/25.
//



struct FoodAppReport:Codable {
    var filterType:Int = 0
    var reportType:Int = 0
    var dateString = ""
    var list:[FoodAppReportData] = []
    
    var total_order = 0
    var total_order_SHF = 0
    var total_order_GRF = 0
    var total_order_GOF = 0
    var total_order_BEF = 0
    
    var total_revenue_amount = 0
    var total_revenue = 0 // this variable is used for screen of FoodAppReportViewController
    var total_amount_SHF = 0
    var total_amount_GRF = 0
    var total_amount_GOF = 0
    var total_amount_BEF = 0

    var percent_SHF = 0
    var percent_GRF = 0
    var percent_GOF = 0
    var percent_BEF = 0
    
  
    init(){}
    
    init(reportType:Int, dateString:String){
        self.reportType = reportType
        self.dateString = dateString
    }
    
    enum CodingKeys: String, CodingKey {
        case list
        case total_order
        case total_order_SHF
        case total_order_GRF
        case total_order_GOF
        case total_order_BEF
        
        case total_revenue_amount
        case total_revenue
        case total_amount_SHF
        case total_amount_GRF
        case total_amount_GOF
        case total_amount_BEF
        
        case percent_SHF
        case percent_GRF
        case percent_GOF
        case percent_BEF
    }
        
      
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.list = try container.decodeIfPresent([FoodAppReportData].self, forKey: .list) ?? []
        
        self.total_order = try container.decodeIfPresent(Int.self, forKey: .total_order) ?? 0
        self.total_order_SHF = try container.decodeIfPresent(Int.self, forKey: .total_order_SHF) ?? 0
        self.total_order_GRF = try container.decodeIfPresent(Int.self, forKey: .total_order_GRF) ?? 0
        self.total_order_GOF = try container.decodeIfPresent(Int.self, forKey: .total_order_GOF) ?? 0
        self.total_order_BEF = try container.decodeIfPresent(Int.self, forKey: .total_order_BEF) ?? 0
        
        self.total_revenue_amount = try container.decodeIfPresent(Int.self, forKey: .total_revenue_amount) ?? 0
        self.total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
        self.total_amount_SHF = try container.decodeIfPresent(Int.self, forKey: .total_amount_SHF) ?? 0
        self.total_amount_GRF = try container.decodeIfPresent(Int.self, forKey: .total_amount_GRF) ?? 0
        self.total_amount_GOF = try container.decodeIfPresent(Int.self, forKey: .total_amount_GOF) ?? 0
        self.total_amount_BEF = try container.decodeIfPresent(Int.self, forKey: .total_amount_BEF) ?? 0
        
        self.percent_SHF = try container.decodeIfPresent(Int.self, forKey: .percent_SHF) ?? 0
        self.percent_GRF = try container.decodeIfPresent(Int.self, forKey: .percent_GRF) ?? 0
        self.percent_GOF = try container.decodeIfPresent(Int.self, forKey: .percent_GOF) ?? 0
        self.percent_BEF = try container.decodeIfPresent(Int.self, forKey: .percent_BEF) ?? 0
    }
    
}

struct FoodAppReportData:Codable{
    var report_date = ""
    
    var total_order_SHF = 0
    var total_order_GRF = 0
    var total_order_GOF = 0
    var total_order_BEF = 0
    
    var commission_amount_SHF = 0
    var commission_amount_GRF = 0
    var commission_amount_GOF = 0
    var commission_amount_BEF = 0
    
    var order_amount_SHF = 0
    var order_amount_GRF = 0
    var order_amount_GOF = 0
    var order_amount_BEF = 0
    
    
    var total_amount_SHF = 0
    var total_amount_GRF = 0
    var total_amount_GOF = 0
    var total_amount_BEF = 0

    init(){}
    
    enum CodingKeys: String, CodingKey {
        case report_date
        
        case total_order_SHF
        case total_order_GRF
        case total_order_GOF
        case total_order_BEF
        
        case commission_amount_SHF
        case commission_amount_GRF
        case commission_amount_GOF
        case commission_amount_BEF
        
        case order_amount_SHF
        case order_amount_GRF
        case order_amount_GOF
        case order_amount_BEF
        
        case total_amount_SHF
        case total_amount_GRF
        case total_amount_GOF
        case total_amount_BEF
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.report_date = try container.decodeIfPresent(String.self, forKey: .report_date) ?? ""
        
        self.total_order_SHF = try container.decodeIfPresent(Int.self, forKey: .total_order_SHF) ?? 0
        self.total_order_GRF = try container.decodeIfPresent(Int.self, forKey: .total_order_GRF) ?? 0
        self.total_order_GOF = try container.decodeIfPresent(Int.self, forKey: .total_order_GOF) ?? 0
        self.total_order_BEF = try container.decodeIfPresent(Int.self, forKey: .total_order_BEF) ?? 0
        
        self.commission_amount_SHF = try container.decodeIfPresent(Int.self, forKey: .commission_amount_SHF) ?? 0
        self.commission_amount_GRF = try container.decodeIfPresent(Int.self, forKey: .commission_amount_GRF) ?? 0
        self.commission_amount_GOF = try container.decodeIfPresent(Int.self, forKey: .commission_amount_GOF) ?? 0
        self.commission_amount_BEF = try container.decodeIfPresent(Int.self, forKey: .commission_amount_BEF) ?? 0
        
        self.order_amount_SHF = try container.decodeIfPresent(Int.self, forKey: .order_amount_SHF) ?? 0
        self.order_amount_GRF = try container.decodeIfPresent(Int.self, forKey: .order_amount_GRF) ?? 0
        self.order_amount_GOF = try container.decodeIfPresent(Int.self, forKey: .order_amount_GOF) ?? 0
        self.order_amount_BEF = try container.decodeIfPresent(Int.self, forKey: .order_amount_BEF) ?? 0
        
        self.total_amount_SHF = try container.decodeIfPresent(Int.self, forKey: .total_amount_SHF) ?? 0
        self.total_amount_GRF = try container.decodeIfPresent(Int.self, forKey: .total_amount_GRF) ?? 0
        self.total_amount_GOF = try container.decodeIfPresent(Int.self, forKey: .total_amount_GOF) ?? 0
        self.total_amount_BEF = try container.decodeIfPresent(Int.self, forKey: .total_amount_BEF) ?? 0
    }


}
