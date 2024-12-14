//
//  CancelReason.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 19/09/2024.
//

import UIKit


struct CancelReason:Codable,Hashable {
    var id = 0
    var content =  ""
    var is_select:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        
    }
    
    
  
    static func getDummyData() -> [CancelReason]{
        var jsonString = """
           [
               {
                   "id": 20446,
                   "content": "Khách yêu cầu hủy món"
               },
               {
                   "id": 20447,
                   "content": "Khách yêu cầu đổi món"
               },
               {
                   "id": 20448,
                   "content": "Khách hủy món do đợi lâu"
               },
               {
                   "id": 20449,
                   "content": "Hết nguyên vật liệu"
               },
               {
                   "id": 20450,
                   "content": "Nhân viên ghi sai order"
               },
               {
                   "id": 20451,
                   "content": "Khách không hài lòng"
               },
               {
                   "id": 20452,
                   "content": "Khác"
               }
            ]
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode the JSON into a User instance
                let list = try JSONDecoder().decode([CancelReason].self, from: jsonData)
                return list

            } catch {
              
                return []
            }
        }
        
        return []
        
    }
}

