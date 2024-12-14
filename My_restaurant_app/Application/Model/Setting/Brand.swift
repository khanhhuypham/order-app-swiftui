//
//  Brand.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 16/01/2023.
//

import UIKit


struct Brand: Codable,Identifiable {
    var id:Int?
    var restaurant_id:Int?
    var name:String?
    var is_office:Int?
    var setting:BrandSetting?
    var isSelect:Bool = false
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case restaurant_id
        case name
        case is_office
        case setting
    }

}

struct BrandSetting: Codable {
    var template_bill_printer_type:Int?
    var is_enable_buffet:Int?
    var payment_type:QRCODE_TYPE? = .pay_os
    
}
