//
//  BuffetDummyData.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 28/09/2024.
//

import UIKit

extension Buffet {
    
    
    static func getDummyData() -> Buffet?{
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode the JSON into a User instance
                let data = try JSONDecoder().decode(Buffet.self, from: jsonData)
                return nil
            } catch {
                
                dLog("Lỗi parse dữ liệu Food")
                return nil
            }
        }
        
        return nil
        
    }
    
    static var jsonString = """
    {
        "name": "Child Ticket",
        "price": 10,
        "quantity": 2,
        "total_amount": 20,
        "discountPercent": 10,
        "discountAmount": 2,
        "discountPrice": 9
    }
    """
}
