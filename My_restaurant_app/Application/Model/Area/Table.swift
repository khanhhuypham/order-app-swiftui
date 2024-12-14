//
//  TableModel.swift
//  TechresOrder
//
//  Created by Kelvin on 14/01/2023.
//





struct Table:Codable,Identifiable,Hashable {
    var id:Int?
    var name:String?
    var status:TableStatus?
    var area_id:Int?
    var order_id:Int?
    var order_status:Int?
    var is_active:Int?
    var is_selected:Bool = false
    var slot_number:Int?
 
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case area_id
        case order_id
        case order_status
        case is_active
        case slot_number
    }
    
    init(name:String){
        self.name = name
    }
    init(){}
    
}

struct CreateTableQuickly:Codable,Hashable {
    var name:String?
    var area_id:Int?
    var is_active:Int?
    var total_slot:Int?
 
    enum CodingKeys: String, CodingKey {
        case name
        case area_id
        case is_active
        case total_slot
    }
  
    init(){}
    init(area_id:Int,name:String,total_slot:Int,is_active:Int = ACTIVE) {
        self.area_id = area_id
        self.name = name
        self.is_active = is_active
        self.total_slot = total_slot
    }

}


