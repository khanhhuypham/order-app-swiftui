//
//  SavedLoginInfor.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//



struct SavedLoginInfor: Codable {
    var ip_address = ""
    var restaurant_name = ""
    var username = ""
    
    
    init() {}
    

    
    init(ip_address:String,restaurant_name:String,username:String) {
        self.ip_address = ip_address
        self.restaurant_name = restaurant_name
        self.username = username
    }
    
    init(restaurant_name:String,username:String) {
        self.restaurant_name = restaurant_name
        self.username = username
    }
    
    // MARK: - CodingKeys
     private enum CodingKeys: String, CodingKey {
         case ip_address = "ip_address"
         case restaurant_name = "restaurant_name"
         case username = "username"
     }

     // MARK: - Custom Decoder
     init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         ip_address = try container.decodeIfPresent(String.self, forKey: .ip_address) ?? ""
         restaurant_name = try container.decodeIfPresent(String.self, forKey: .restaurant_name) ?? ""
         username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
     }
}
