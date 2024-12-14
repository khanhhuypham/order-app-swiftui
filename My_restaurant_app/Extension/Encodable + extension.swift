//
//  Encodable + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 25/09/2024.
//

import UIKit

extension Encodable {
  
    
    func toJSON() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)!

            
            return jsonString
          
        } catch {
            print(error)
        }
        return ""
    }
    
    func toDictionary() -> Any? {
        do {
            // Encode the input (could be a single object or an array of objects)
            let jsonData = try JSONEncoder().encode(self)
            
            // Deserialize into either a dictionary (for a single object) or an array of dictionaries (for arrays)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                // Single object case
                return jsonObject
            } else if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: Any]] {
                // Array of objects case
                return jsonArray
            }
        } catch {
            print("Error converting struct(s) to dictionary: \(error)")
        }
        return nil
    }
    
    
    
}

