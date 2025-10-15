//
//  OrderStatistic.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 11/10/25.
//


struct OrderStatistic: Codable {

    var total_amount = 0

    enum CodingKeys: String, CodingKey {
        case total_amount
        
    }
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total_amount = try container.decodeIfPresent(Int.self, forKey: .total_amount) ?? 0
       
    }
}
