//
//  Branch.swift
//  SwiftUI-Demo
//
//  Created by Pham Khanh Huy on 12/09/2024.
//

import UIKit


struct Branch: Codable,Identifiable {
    var id:Int?
    var restaurant_brand_id:Int?
    var name:String?
    var phone:String?
    var address:String?
    var status:Int?
    var is_use_fingerprint:Int?
    var is_enable_checkin:Int?
    var avatar:String?
    var is_office:Int?
    var image_logo:String?
    var banner:String?
    var image_logo_url:String?
    var banner_image_url:String?
    
    
    struct BranchSetting: Codable {
        var is_show_vat_on_items_in_bill:Int?
        var is_hidden_payment_detail_in_bill:Int?
        var vat_content_on_bill:String?
        var greeting_content_on_bill:String?
    }
}
