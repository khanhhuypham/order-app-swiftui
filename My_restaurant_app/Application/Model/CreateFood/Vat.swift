//
//  Vat.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 18/10/25.
//




struct Vat: Codable,Identifiable {
    var id = 0
    var vat_config_id = 0
    var vat_config_name = ""
    var restaurant_id = 0
    var percent = 0.0
    var admin_percent = 0.0
    var created_at = ""
    var updated_at = ""
    var is_updated = 0
    var is_actived = 0
    var isSelect:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case vat_config_id
        case vat_config_name
        case restaurant_id
        case percent
        case admin_percent
        case created_at
        case updated_at
        case is_updated
        case is_actived
    }

    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
       vat_config_id = try container.decodeIfPresent(Int.self, forKey: .vat_config_id) ?? 0
       vat_config_name = try container.decodeIfPresent(String.self, forKey: .vat_config_name) ?? ""
       restaurant_id = try container.decodeIfPresent(Int.self, forKey: .restaurant_id) ?? 0
       percent = try container.decodeIfPresent(Double.self, forKey: .percent) ?? 0.0
       admin_percent = try container.decodeIfPresent(Double.self, forKey: .admin_percent) ?? 0.0
       created_at = try container.decodeIfPresent(String.self, forKey: .created_at) ?? ""
       updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at) ?? ""
       is_updated = try container.decodeIfPresent(Int.self, forKey: .is_updated) ?? 0
       is_actived = try container.decodeIfPresent(Int.self, forKey: .is_actived) ?? 0
    }
}
