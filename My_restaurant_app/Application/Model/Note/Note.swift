//
//  Note.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//



struct Note:Codable,Identifiable {
    var id:Int = 0
    var branch_id:Int?
    var content:String = ""
    var delete:Int?
  
    enum CodingKeys: String, CodingKey {
        case id
        case branch_id
        case content
        case delete
      
    }
    
    init() {}
}

