//
//  Branch.swift
//  SwiftUI-Demo
//
//  Created by Pham Khanh Huy on 12/09/2024.
//

import UIKit


struct Branch: Codable,Identifiable {
    var id:Int = 0
    var restaurant_brand_id:Int = 0
    var name:String = ""
    var phone:String = ""
    var address:String = ""
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
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        restaurant_brand_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_brand_id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        is_use_fingerprint = try container.decodeIfPresent(Int.self, forKey: .is_use_fingerprint)
        is_enable_checkin = try container.decodeIfPresent(Int.self, forKey: .is_enable_checkin)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        is_office = try container.decodeIfPresent(Int.self, forKey: .is_office)
        image_logo = try container.decodeIfPresent(String.self, forKey: .image_logo)
        banner = try container.decodeIfPresent(String.self, forKey: .banner)
        image_logo_url = try container.decodeIfPresent(String.self, forKey: .image_logo_url)
        banner_image_url = try container.decodeIfPresent(String.self, forKey: .banner_image_url)
    }
}
