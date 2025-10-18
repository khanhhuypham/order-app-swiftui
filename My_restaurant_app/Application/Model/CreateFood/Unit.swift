//
//  Unit.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 17/10/25.
//


struct Unit: Codable,Identifiable {
    var id:Int?
    var code:String?
    var name:String?
    var isSelect:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case name
      
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}
