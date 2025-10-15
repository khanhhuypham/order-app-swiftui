//
//  OrderDetailItem.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 07/05/2024.
//

import UIKit





struct OrderDetailAddition: Codable,Hashable {
    
    var id:Int
    var name:String
    var price:Int
    var total_price:Int
    var quantity:Float
//    var rateInfo = ReviewFoodData()
    var vat_percent:Int
//    var discountAmount:Int
//    var discountPercent:Int
//    var discountPrice:Int
//    var isSelected:Int = DEACTIVE
    var isChange:Int = DEACTIVE
    

//    init(id:Int,name:String,quantity:Float,price:Int,total_price:Int,discountAmount:Int = 0,discountPercent:Int = 0, discountPrice:Int = 0){
//        self.id = id
//        self.name = name
//        self.quantity = quantity
//        self.price = price
//        self.total_price = total_price
////        self.discountAmount = discountAmount
////        self.discountPercent = discountPercent
////        self.discountPrice = discountPrice
//    }
//    
    

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case total_price
        case quantity
        case vat_percent
        
    }
    
    
    mutating func increaseByOne() -> Void {

        let maximumNumber:Float = 1000
       
        if self.quantity != maximumNumber{
            self.quantity += 1
            self.isChange = ACTIVE
        }
    }

    
     mutating func decreaseByOne() -> Void {
        if self.quantity != 0{
            self.quantity -= 1
            self.isChange = ACTIVE
        }
        self.quantity = self.quantity <= 0 ? 0 : self.quantity
    }

}
