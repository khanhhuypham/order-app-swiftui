//
//  Buffet.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 22/04/2024.
//

import UIKit

struct BuffetResponse:Codable{

    var total_record:Int
    var limit:Int
    var list:[Buffet]
    
    enum CodingKeys: String, CodingKey {
        case total_record
        case limit
        case list
    }
    
}

struct Buffet:Codable,Identifiable {
    var id:Int = 0
    var name:String?
    var buffet_ticket_id:Int?
    var buffet_ticket_name:String?
    var adult_price:Double = 0
    var child_price:Double = 0
    var status:Int = 1

    var ticketChildren:[BuffetTicketChild] = []

    var adult_quantity:Int?
    var adult_discount_percent:Double?
    var adult_discount_amount:Double?
    var adult_discount_price:Double?

    var child_quantity:Int?
    var child_discount_percent:Double?
    var child_discount_amount:Double?
    var child_discount_price:Double?
    
    var total_adult_amount:Double?
    var total_child_amount:Double?
    var total_final_amount:Double?
    /*------------------------*/
    var quantity = 0
  
    var isSelect:Bool = false
    /*------------------------*/
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case buffet_ticket_id
        case buffet_ticket_name
        case adult_price
        case child_price
        case status
        
        case adult_quantity
        case adult_discount_percent
        case adult_discount_amount
        case adult_discount_price

        case child_quantity
        case child_discount_percent
        case child_discount_amount
        case child_discount_price
        
        case total_adult_amount
        case total_child_amount
        case total_final_amount
    }
    

    
    mutating func select() -> Void {
        isSelect = true
        if quantity <= 0 && isSelect{
            quantity = 1

            if let position = ticketChildren.firstIndex(where: {$0.ticketType == .adult}){
                ticketChildren[position].select()
            }
        
        }
    }
    
 
    mutating func deSelect() -> Void {
        isSelect = false
        
        if isSelect == false{
            quantity = 0
            adult_discount_percent = 0
            child_discount_percent = 0
             
            for (i,_) in ticketChildren.enumerated(){
                ticketChildren[i].deSelect()
            }
        }
    }

    mutating func setQuantity(quantity:Int) -> Void {
        
        let maximumNumber = 999
        self.quantity = quantity
        isSelect = true
        
        if quantity >= maximumNumber {
            self.quantity = 999
        }
  
    }
    
    
    mutating func updateTickets() {
        
        if child_price > 0{
            
            var ticketArray:[BuffetTicketChild] = []
            
            ticketArray.append(BuffetTicketChild(
                name: "Vé người lớn",
                ticketType: .adult,
                price: adult_price,
                quantity: adult_quantity ?? 0,
                totalAmount: total_adult_amount ?? 0,
                discountPercent: adult_discount_percent ?? 0,
                discountAmount: adult_discount_amount ?? 0,
                discountPrice: adult_discount_price ?? 0
            ))
            
            ticketArray.append(BuffetTicketChild(
                name: "Vé trẻ em",
                ticketType: .children,
                price: child_price,
                quantity: child_quantity ?? 0,
                totalAmount: total_child_amount ?? 0,
                discountPercent: child_discount_percent ?? 0,
                discountAmount: child_discount_amount ?? 0,
                discountPrice: child_discount_price ?? 0
            ))
            self.ticketChildren = ticketArray
        }
    }
}








enum BuffetTicketType:Codable{
    case adult
    case children
}

struct BuffetTicketChild:Identifiable {
    var id = UUID().uuidString
    var name: String = ""
    var price: Double = 0.0
    var quantity: Int = 0
    var totalAmount: Double = 0.0
    var discountPercent: Double = 0.0
    var discountAmount: Double = 0.0
    var discountPrice: Double = 0.0
    var ticketType: BuffetTicketType = .adult
    var isSelect: Bool = false


    init(){}
    
    init(name:String,ticketType:BuffetTicketType,price:Double,quantity:Int,totalAmount:Double,discountPercent:Double,discountAmount:Double,discountPrice:Double){
        self.name = name
        self.ticketType = ticketType
        self.price = price
        self.quantity = quantity
        self.totalAmount = totalAmount
        self.discountPercent = discountPercent
        self.discountAmount = discountAmount
        self.discountPrice = discountPrice
    }
    

    mutating func select() -> Void {
        isSelect = true
        if quantity <= 0 && isSelect{
            quantity = 1
        }
    }
    
    
    mutating func deSelect() -> Void {
        isSelect = false
        
         if isSelect == false{
            quantity = 0
            discountPercent = 0
        }
    }
    
    

    mutating func increaseByOne() -> Void {
      
        let maximumNumber = 999
       
        quantity += 1
        isSelect = true
        
        if quantity >= maximumNumber {
            
            quantity = 999
        }
       

    }

    
    
    mutating func decreaseByOne() -> Void {
       
        quantity -= 1

        if quantity <= 0 {
            quantity = 0
            isSelect = false
        }
    }
    
    
    
    mutating func setQuantity(quantity:Int) -> Void {

        let maximumNumber = 999
        self.quantity = quantity
        isSelect = true
        
        if quantity >= maximumNumber {
            self.quantity = 999
        }else if quantity == 0{
            isSelect = false
        }
    }
    
    
        
}
