//
//  Account.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit



struct Account: Codable {
    var id:Int?
    var access_token:String? = ""
    var branch_type:Int?
    var avatar:String?
    var branch_id:Int?
    var city_id:Int?
    var district_id:Int?
    var ward_id:Int?
    var employee_id:Int?
    var name:String?
    var birthday:String?
    var phone_number:String?
    var restaurant_id:Int?
    var username:String?
    var password:String?
    var permissions:[String]?
    var restaurant_brand_id = 0
    var city_name:String?
    var district_name:String?
    var ward_name:String?
    var is_branch_office:Int?
    var is_enable_change_password:Int?
    var brand_name:String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case access_token
        case branch_type
        case avatar
        case branch_id
        case city_id
        case district_id
        case ward_id
        case employee_id
        case name
        case birthday
        case phone_number
        case restaurant_id
        case username
        case password
        case permissions
        case restaurant_brand_id
        case city_name
        case district_name
        case ward_name
        case is_branch_office
        case is_enable_change_password

        case brand_name = "restaurant_brand_name"
    }
}



