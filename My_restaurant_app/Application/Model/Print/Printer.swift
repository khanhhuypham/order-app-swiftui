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
    var port:Int = 0
    var connection_type:CONNECTION_TYPE = .wifi
    var number_of_copies:Int = 0
    var is_print_each_paper:Bool = false
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
        port = try container.decodeIfPresent(Int.self, forKey: .port) ?? 0
        connection_type = try container.decodeIfPresent(CONNECTION_TYPE.self, forKey: .connection_type) ?? .wifi // assuming .unknown is a default case
        number_of_copies = try container.decodeIfPresent(Int.self, forKey: .number_of_copies) ?? 0
        is_print_each_paper = try container.decodeIfPresent(Bool.self, forKey: .is_print_each_paper) ?? false
        active = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        type = try container.decodeIfPresent(PRINTER_TYPE.self, forKey: .type) ?? .chef // assuming .unknown is a default case
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case printer_name
        case ip_address
        case port
        case connection_type
        case number_of_copies = "print_number"
        case is_print_each_paper
        case active
        case type
    }
}

