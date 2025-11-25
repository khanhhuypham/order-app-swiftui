//
//  Printer.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 02/12/2024.
//

import UIKit


struct Printer: Codable,Identifiable {
    var id:Int = 0
    var name:String = ""
    var printer_name:String = ""
    var ip_address:String = ""
    var port:String = ""
    var paper_size:Int = 0
    var description = ""
    var connection_type:CONNECTION_TYPE = .wifi
    var number_of_copies:Int = 0
    var print_each_paper:Bool = false
    var direction:Int = 0
    var status = 0
    var active:Bool = false
    var type:PRINTER_TYPE = .chef
    var isSelect:Bool = false
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        printer_name = try container.decodeIfPresent(String.self, forKey: .printer_name) ?? ""
        ip_address = try container.decodeIfPresent(String.self, forKey: .ip_address) ?? ""
        port = try container.decodeIfPresent(String.self, forKey: .port) ?? ""
        paper_size = try container.decodeIfPresent(Int.self, forKey: .paper_size) ?? 0
        description = try container.decodeIfPresent(String.self, forKey: .port) ?? ""
        connection_type = try container.decodeIfPresent(CONNECTION_TYPE.self, forKey: .connection_type) ?? .wifi // assuming .unknown is a default case
        number_of_copies = try container.decodeIfPresent(Int.self, forKey: .number_of_copies) ?? 0
      
        
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .print_each_paper) {
            print_each_paper = (intValue == 1)
        } else {
            print_each_paper = try container.decodeIfPresent(Bool.self, forKey: .print_each_paper) ?? false
        }
        direction = try container.decodeIfPresent(Int.self, forKey: .direction) ?? 0
        let intValue = try container.decode(Int.self, forKey: .active)
        active = (intValue == 1) // Convert 1 to true, anything else to false
        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
        type = try container.decodeIfPresent(PRINTER_TYPE.self, forKey: .type) ?? .chef // assuming .unknown is a default case
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case printer_name
        case ip_address = "printer_ip_address"
        case port = "printer_port"
        case paper_size = "printer_paper_size"
        case description
        case connection_type
        case number_of_copies = "print_number"
        case print_each_paper = "is_print_each_food"
        case direction = "location_stamp"
        case status
        case active = "is_have_printer"
        case type
    }
}


