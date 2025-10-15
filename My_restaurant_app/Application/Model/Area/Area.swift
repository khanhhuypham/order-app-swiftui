//
//  Area.swift
//  TechresOrder
//
//  Created by Kelvin on 14/01/2023.
//




struct Area:Identifiable, Codable {
    var id:Int = 0
    var name:String = ""
    var status:Int = 0
    var table_count:Int = 0
    var is_take_away:Int = DEACTIVE
    var isSelect:Bool = false
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case table_count
        case is_take_away
    }
    
    init(id:Int, name:String, isSelect:Bool){
        self.id = id
        self.name = name
        self.isSelect = isSelect
    }
   
}


extension Area {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        table_count = try container.decodeIfPresent(Int.self, forKey: .table_count) ?? 0
        is_take_away = try container.decodeIfPresent(Int.self, forKey: .is_take_away) ?? DEACTIVE
    }
}
