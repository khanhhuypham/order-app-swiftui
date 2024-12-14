//
//  Area.swift
//  TechresOrder
//
//  Created by Kelvin on 14/01/2023.
//




struct Area: Codable {
    var id:Int = 0
    var name:String = ""
    var status:Int = 0

    var is_take_away:Int = DEACTIVE
    var isSelect:Bool = false
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
//        case is_take_away
    }
    
    init(id:Int, name:String, isSelect:Bool){
        self.id = id
        self.name = name
        self.isSelect = isSelect
    }
   
}
