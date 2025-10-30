//
//  MoveOrderItemsViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/10/25.
//
import SwiftUI
import AlertToast
class MoveOrderItemsViewModel: ObservableObject {
    @Injected(\.utils.toastUtils) var toast

    var order:Order = .init()
    @Published public var dataArray:[OrderItem] = []
   
    
    func getOrdersNeedMove() async{
        
        let result: Result<APIResponse<OrderDetail>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .ordersNeedMove(
                branch_id:Constants.branch.id,
                order_id: order.id,
                food_status: String(format: "%d,%d,%d", ORDER_ITEM_STATUS.pending.rawValue, ORDER_ITEM_STATUS.cooking.rawValue, ORDER_ITEM_STATUS.done.rawValue)
            )
        )
        
        switch result {
            case .success(let res):
            
                if res.status == .ok,let data = res.data{
                    dataArray = data.orderItems
                    
                    await toast.alertSubject.send(
                        AlertToast(type: .regular, title: "Warning", subTitle: "Huỷ bản thành công")
                    )
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func moveFoods(from:Int,to:Int,selectedItems:[FoodSplitRequest]) async{
        
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .moveFoods(
                branch_id:Constants.branch.id,
                order_id:order.id,
                destination_table_id:from,
                target_table_id:to,
                foods: selectedItems
            )
        )
        
        switch result {
            case .success(let res):
                if res.status == .ok{
                    dLog(res.message)
//                    JonAlert.showSuccess(message: "Tách món thành công.", duration: 2.0)
                }
                break
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }


   
}
