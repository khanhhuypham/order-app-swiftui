////
////  FoodSplitRequest.swift
////  TechresOrder
////
////  Created by Kelvin on 19/01/2023.
////
//


struct FoodSplitRequest: Codable {
    var order_detail_id = 0
    var quantity: Float = 0
   
    // Define the coding keys that map to your JSON keys
    enum CodingKeys: String, CodingKey {
       case order_detail_id
       case quantity
    }

    // Default initializer
    init() {}

   // Decoder initializer (for decoding from JSON)
   init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       order_detail_id = try container.decodeIfPresent(Int.self, forKey: .order_detail_id) ?? 0
       quantity = try container.decodeIfPresent(Float.self, forKey: .quantity) ?? 0.0
   }
}
//struct ExtraFoodSplitRequest: Mappable {
//    var extra_charge_id = 0
//    var quantity: Float = 0
//   
//    init() {}
//     init?(map: Map) {
//    }
// 
//
//    mutating func mapping(map: Map) {
//        extra_charge_id <- map["extra_charge_id"]
//        quantity <- map["quantity"]
//    }
//}
