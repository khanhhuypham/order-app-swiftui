//
//  FoodViewModel + extension + addFood.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 1/11/25.
//

import UIKit

extension FoodViewModel {
    func processToAddFood(){
        
        if !selectedFoods.isEmpty{
        
            let items = selectedFoods.filter{$0.isSelect}.map{(food) in
                var food_request = FoodRequest.init()
                food_request.id = food.id
                food_request.quantity = food.quantity
                food_request.note = food.note
                food_request.discount_percent = food.discount_percent
                food_request.price = food.price_with_temporary
                //CHECK ADDITION FOOD
                food_request.addition_foods = food.addition_foods.filter{$0.isSelect && $0.quantity > 0}
                // CHECK MUA 1 TANG 1
                food_request.buy_one_get_one_foods = food.food_list_in_promotion_buy_one_get_one.filter{$0.isSelect && $0.quantity > 0}
                
                
                // Compose food options
                food_request.food_option_foods = food.food_options.flatMap { option in
                 
                    option.addition_foods.filter{ $0.isSelect}.map { addition in
                        [
                            "id": addition.id,
                            "quantity": addition.quantity,
                            "food_option_id": option.id
                        ]
                    }
                 
                }
                
                
                return food_request
            }
            
            Task{
                await APIParameter.is_allow_employee_gift == ADD_GIFT ? addGiftFoods(items:items) : addFoods(items:items)
            }
        }
        
        
        
        if var buffetTiket = selectedBuffet{
            
            if buffetTiket.ticketChildren.isEmpty{
                buffetTiket.adult_quantity = buffetTiket.quantity
            }else{
                for ticket in  buffetTiket.ticketChildren{
                    if ticket.ticketType == .adult{
                        buffetTiket.adult_quantity = ticket.quantity
                    }else if ticket.ticketType == .children {
                        buffetTiket.child_quantity = ticket.quantity
                    }
                }
            }

//            createBuffetTicket(buffet: buffetTiket)
        }
        
        
    }
}
