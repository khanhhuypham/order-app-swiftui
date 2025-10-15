//
//  EmployeeRevenueReport.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 10/10/25.
//



struct EmployeeRevenueReport:Codable{
    
    
    var reportType = 0
    var dateString = ""
    var fromDate = ""
    var toDate = ""
    var data:[EmployeeRevenue] = []
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

    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([EmployeeRevenue].self, forKey: .data) ?? []
        total_revenue = try container.decodeIfPresent(Int.self, forKey: .total_revenue) ?? 0
    }

   
    
}


struct EmployeeRevenue:Codable {
    
    var employee_id = 0
    var avatar = ""
    var username =  ""
    var employee_name = ""
    var employee_role_name = ""
    var order_count = 0
    var revenue = 0
    
    enum CodingKeys: String, CodingKey {
        case employee_id
        case avatar
        case username
        case employee_name
        case employee_role_name
        case order_count
        case revenue
    }

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employee_id = try container.decodeIfPresent(Int.self, forKey: .employee_id) ?? 0
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        employee_name = try container.decodeIfPresent(String.self, forKey: .employee_name) ?? ""
        employee_role_name = try container.decodeIfPresent(String.self, forKey: .employee_role_name) ?? ""
        order_count = try container.decodeIfPresent(Int.self, forKey: .order_count) ?? 0
        revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0
    }
    
    
}
