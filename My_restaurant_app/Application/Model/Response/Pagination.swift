//
//  Pagination.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 8/12/25.
//


struct Pagination<T: Codable>: Codable {
    var list:T
    var limit:Int = 0
    var page:Int = 0
    var total_record:Int = 0
  
    private enum CodingKeys: String, CodingKey {
        case list
        case limit
        case page
        case total_record
    }
    
    
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      
        list = try container.decode(T.self, forKey: .list)
        limit = try container.decodeIfPresent(Int.self, forKey: .limit) ?? 0
        page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 0
        total_record = try container.decodeIfPresent(Int.self, forKey: .total_record) ?? 0
    }
}

