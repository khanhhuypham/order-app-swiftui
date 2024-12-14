//
//  Payment.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 04/11/2023.
//

import UIKit



struct Payment {
    var order_id = 0
    var tip_amount = 0
    var bank_amount = 0
    var transfer_amount = 0
    var cash_amount = 0
    var payment_method = 0

    

    init(){}
}

struct PaymentMethod:Codable {
    var is_apply_only_cash_amount_payment_method:Int?
    var is_enable_send_to_kitchen_request:Int?
    var is_enable_food_court:Int?
    var is_hidden_payment_detail_in_bill:Int?
    var is_show_vat_on_items_in_bill:Int?
    var is_enable_checkin:Int?
    var vat_content_on_bill:String?
    var greeting_content_on_bill:String?

}

