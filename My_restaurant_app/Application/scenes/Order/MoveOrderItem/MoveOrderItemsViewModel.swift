//
//  MoveOrderItemsViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/10/25.
//
import SwiftUI

class MoveOrderItemsViewModel: ObservableObject {
    @Injected(\.utils.toastUtils) var toast

    var order:Order = .init()
    @Published public var dataArray:[OrderItem] = []
   
    
    func getOrdersNeedMove() async{
        
        let result: Result<APIResponse<OrderDetail>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .ordersNeedMove(
                branch_id:Constants.branch.id,
                order_id: order.id,
                food_status: String(format: "%d,%d,%d", FOOD_STATUS.pending.rawValue, FOOD_STATUS.cooking.rawValue, FOOD_STATUS.done.rawValue)
            )
        )
        
        switch result {
            case .success(let res):
            
                if res.status == .ok{
                    dataArray = res.data.orderItems
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func moveFoods(selectedItems:[FoodSplitRequest]) async{
        
        let result: Result<APIResponse<OrderDetail>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
                .moveFoods(
                    branch_id:Constants.branch.id,
                    order_id:order.id,
                    destination_table_id:0,
                    target_table_id:0,
                    foods: selectedItems
                )
        )
        
        switch result {
            case .success(let res):
                break
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }


   
}
