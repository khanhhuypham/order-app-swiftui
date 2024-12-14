////
////  NoteRequest.swift
////  TechresOrder
////
////  Created by macmini_techres_03 on 01/02/2023.
////


struct NoteRequest:Codable,Identifiable {
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

