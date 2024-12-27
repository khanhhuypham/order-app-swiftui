//
//  TableModel.swift
//  TechresOrder
//
//  Created by Kelvin on 14/01/2023.
//


struct Table:Codable,Identifiable{
    var id:Int = 0
    var name:String?
    var status:TableStatus?
    var area_id:Int?
    var order:PrivateOrder?
    var active:Bool?
    var slot_number:Int?
    var is_selected:Bool = false
 
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case area_id
        case order
        case active
        case slot_number
    }
    
    init(name:String){
        self.name = name
    }
    
    init(){}
    
    struct PrivateOrder:Codable {
        var id:Int?
        var status:OrderStatus?
        enum CodingKeys: String, CodingKey {
            case id
            case status
        }
    }
    
}

struct CreateTableQuickly:Codable,Hashable {
    var name:String?
    var area_id:Int?
    var active:Bool?
    var total_slot:Int?
 
    enum CodingKeys: String, CodingKey {
        case name
        case area_id
        case active
        case total_slot
    }
  
    init(){}
    
    init(area_id:Int,name:String,total_slot:Int,active:Bool = true) {
        self.area_id = area_id
        self.name = name
        self.active = active
        self.total_slot = total_slot
    }

}


