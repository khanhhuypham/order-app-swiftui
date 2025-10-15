//
//  AuthenticationToken.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//



struct AuthenticationToken: Codable {
    var id = 0
    var status = 0
    var user_id = 0
    var username=""
    var client_id = ""
    var code = ""
    var expire_at = ""
  
    private enum CodingKeys: String, CodingKey {
          case id
          case status
          case user_id
          case username
          case client_id
          case code
          case expire_at
      }
      
      init() {}
      
      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          
          self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
          self.status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
          self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id) ?? 0
          self.username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
          self.client_id = try container.decodeIfPresent(String.self, forKey: .client_id) ?? ""
          self.code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
          self.expire_at = try container.decodeIfPresent(String.self, forKey: .expire_at) ?? ""
      }
    

}
