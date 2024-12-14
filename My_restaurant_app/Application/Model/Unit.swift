//
//  Unit.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 02/12/2024.
//

import UIKit


struct Unit: Codable,Identifiable {
    var id:Int
    var name:String
    var isSelect:Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case name
       
    }
}
