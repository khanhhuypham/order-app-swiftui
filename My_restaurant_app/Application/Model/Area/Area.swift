//
//  Area.swift
//  TechresOrder
//
//  Created by Kelvin on 14/01/2023.
//




struct Area {
    var id:Int = 0
    var name:String = ""
    var active:Bool = false
    var is_take_away:Int = DEACTIVE
    var isSelect:Bool = false
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case active
    }
    
    init(id:Int, name:String, isSelect:Bool){
        self.id = id
        self.name = name
        self.isSelect = isSelect
    }
   
}

extension Area: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        active = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
    }
}


