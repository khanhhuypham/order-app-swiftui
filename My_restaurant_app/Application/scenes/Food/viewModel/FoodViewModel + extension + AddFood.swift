//
//  FoodViewModel + extension + AddFood.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 08/10/2024.
//

import UIKit

extension FoodViewModel {
    
    func processToAddFood(){
        
        if !selectedFoods.isEmpty{
        
            let items = selectedFoods.map{(food) in
                var food_request = FoodRequest.init()
                food_request.id = food.id
                food_request.quantity = food.quantity
                food_request.note = food.note
                food_request.discount_percent = food.discount_percent
                //CHECK ADDITION FOOD
                food_request.addition_foods = food.addition_foods.filter{$0.isSelect && $0.quantity > 0}
                // CHECK MUA 1 TANG 1
                food_request.buy_one_get_one_foods = food.food_list_in_promotion_buy_one_get_one.filter{$0.isSelect && $0.quantity > 0}
                return food_request
            }
            APIParameter.is_allow_employee_gift == ADD_GIFT ? addGiftFoods(items:items) : addFoods(items:items)
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
    
    //    //MARK: API thêm món ăn vào order
    private func addFoods(items:[FoodRequest]){
                
        NetworkManager.callAPI(netWorkManger:.addFoods(
            branch_id: Constants.branch.id ?? 0,
            order_id: order.id,
            foods: items,
            is_use_point: APIParameter.is_use_point
        )){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                    guard let res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
             
                    if (res.status == .ok) {
            
                        self.navigateTag = 0
                    } else if (res.status == .badRequest) {
                        dLog(res.message ?? "")
                    } else {
                        dLog(res.message ?? "")
                    }
                    
                
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    //
    private func addGiftFoods(items:[FoodRequest]) {
        NetworkManager.callAPI(netWorkManger: .addGiftFoods(
            branch_id: Constants.branch.id ?? 0,
            order_id: order.id,
            foods: items,
            is_use_point: APIParameter.is_use_point
        )){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let data):

                    guard let res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }

                    if (res.status == .ok) {
                        self.navigateTag = 0
                    } else if (res.status == .badRequest) {
                        dLog(res.message ?? "")
                    } else {
                        dLog(res.message ?? "")
                    }

                case .failure(let error):
                  print(error)
            }
        }

    }
    //    //MARK: API order tại bàn
        func createDineInOrder(){
            
        
            NetworkManager.callAPI(netWorkManger:.openTable(table_id: order.table_id)){[weak self] result in
                guard let self = self else { return }
                
                switch result {
                    case .success(let data):
                        guard let res = try? JSONDecoder().decode(APIResponse<Table>.self, from: data) else{
                            dLog("parse model sai rồi")
                            return
                        }
                    
                        if (res.status == .ok) {
                            order = OrderDetail(table: res.data)
                            processToAddFood()
                            self.navigateTag = 1
                        } else if (res.status == .badRequest) {
                            dLog(res.message ?? "")
                        } else {
                            dLog(res.message ?? "")
                        }
                    
                
                      case .failure(let error):
                        dLog(error)
                }
            }
            
            
        }
    //
    //    //MARK: API tạo order mới, trong trường hợp mang về.
        func createTakeOutOder() {

            NetworkManager.callAPI(netWorkManger: .postCreateOrder(branch_id: Constants.branch.id ?? 0,table_id: order.table_id, note: "")){[weak self] result in
                guard let self = self else { return }
                
                switch result {
                      case .success(let data):
                        dLog(data)
                        break
                
                      case .failure(let error):
                        dLog(error)
                }
            }
        }
}
