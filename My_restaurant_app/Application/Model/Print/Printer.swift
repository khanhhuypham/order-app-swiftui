//
//  Printer.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 02/12/2024.
//

import UIKit


struct Printer: Codable,Identifiable {
    var id:Int
    var name:String
    var printer_name:String
    var ip_address:String
    var port:Int
    var connection_type:CONNECTION_TYPE
    var print_number:Int
    var is_print_each_paper:Bool
    var active:Bool
    var type:PRINTER_TYPE
    var isSelect:Bool = false
 
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case printer_name
        case ip_address
        case port
        case connection_type
        case print_number
        case is_print_each_paper
        case active
        case type
    }
}

