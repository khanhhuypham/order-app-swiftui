//
//  OrderDetailViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 12/09/2024.
//

import UIKit
import SwiftUI
import AlertToast

enum PopupType{
    case note
    case discount
    case edit
    case split
    case cancel
}

class OrderDetailViewModel: ObservableObject {
    @Injected(\.utils.toastUtils) var toast
    let socketManager = SocketIOManager.shared
    @Published var order:OrderDetail = OrderDetail()
        
    @Published var printItems:[PrintItem] = []
    

    @Published var showSheet:(show:Bool,type:OrderAction) = (false,.splitFood)
    var splitFood:(from:Table,to:Table)? = nil

    @Published public var showPopup:(
        show:Bool,
        type:PopupType,
        item:OrderItem?
    ) = (false,.cancel,nil)
    
    
    
    init(order:Order? = nil){
        if let orderDetail = order{
            self.order = OrderDetail(order: orderDetail)
        }else{
            self.order = OrderDetail()
        }
    }
    
    
    func getOrder() async{
        
        let result: Result<APIResponse<OrderDetail>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.order(order_id: order.id , branch_id: Constants.branch.id))
        
        switch result {
            case .success(var res):
            
                if res.status == .ok{
                    if res.data.buffet != nil{
                        res.data.buffet?.updateTickets()
                    }

                    self.order = res.data

                    order.orderItems.removeAll(where: {($0.category_type == .drink || $0.category_type == .other) && $0.quantity == 0})

                    await self.getFoodsNeedPrint()

                    //Nếu bàn booking thì sẽ lấy thêm các món ăn
                    if let booking_status = order.booking_status,booking_status == .status_booking_setup{
                        await self.getBookingOrder()
                    }
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }


    // Method to increase the quantity of an item
    func setQuantity(for item: OrderItem, quantity:Float) {
        if let index = order.orderItems.firstIndex(where: { $0.id == item.id }) {
            
            order.orderItems[index].setQuantity(quantity: quantity)
            
        }
    }
    

   
}
extension OrderDetailViewModel{
    
    func getFoodsNeedPrint() async{
        
        let result: Result<APIResponse<[PrintItem]>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.foodsNeedPrint(order_id: order.id))
        
        switch result {
            case .success(var res):
            
                if res.status == .ok{
                    self.printItems = res.data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }

    func getBookingOrder() async{
        
        let result: Result<APIResponse<[PrintItem]>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.getFoodsBookingStatus(order_id: order.id))
      
        switch result {
            case .success(var res):
            
                if res.status == .ok{
                    var bookingItems = res.data

                    bookingItems.enumerated().forEach{(i,_) in
                        bookingItems[i].is_booking_item = ACTIVE
                    }

                    self.printItems += bookingItems
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
   
    
    

    
    
    //MARK: API Huỷ món
    func cancelItem(item:OrderItem,reason:String) async{
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .cancelFood(
                branch_id: Constants.branch.id,
                order_id: order.id,
                reason: reason,
                order_detail_id: item.id,
                quantity: Int(item.quantity)
        ))
      
        switch result {
            case .success(var res):
                
                if res.status != .ok{
                    await toast.alertSubject.send(
                        AlertToast(type: .regular, title: "warning", subTitle: res.message)
                    )
                }

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func discountOrderItem(item:OrderItem) async{
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .postDiscountOrderItem(branch_id: Constants.branch.id, orderId: order.id, orderItem: item)
        )
     
        
        switch result {

            case .success(let res):
                if res.status != .ok{
                    dLog(res.message)
                }
                break

                
            case .failure(let error):
               dLog("Error: \(error)")
        }
        
    }
    
    func addNote(orderDetailId:Int,note:String) async{
        
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .addNoteToOrder(branch_id: Constants.branch.id, order_detail_id:orderDetailId, note:note)
        )
    
        switch result {

            case .success(let res):
                if res.status != .ok{
                    await toast.alertSubject.send(
                        AlertToast(type: .regular, title: "warning", subTitle: res.message)
                    )
                }
                break

                
            case .failure(let error):
               dLog("Error: \(error)")
            
        }
        
      
    }
    
    
    
    func updateItems() async{
        let orderItemsUpdate = repairUpdateFoods(items: order.orderItems)
        
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger:
            .updateFoods(branch_id: Constants.branch.id, order_id: order.id, orderItemUpdate:orderItemsUpdate)
        )
    
        
        switch result {

            case .success(_):
                break

                
            case .failure(let error):
               dLog("Error: \(error)")
            
        }
        
    }

    

    
    
   private func repairUpdateFoods(items:[OrderItem]) -> [OrderItemUpdate]{
        var itemArrayNeedToUpdate:[OrderItemUpdate] = []
        let foods = items.filter{$0.isChange}
        for food in foods{
            var itemNeedToUpdate = OrderItemUpdate()
            itemNeedToUpdate.order_detail_id = food.id
            itemNeedToUpdate.quantity = food.quantity
            itemNeedToUpdate.note = food.note
            itemNeedToUpdate.price = Int(food.price)
            itemNeedToUpdate.discount_percent = food.discount_percent
            
            for option in food.order_detail_options{
                for optionItem in option.food_option_foods{
                    let optionDetail = OptionUpdate.init(
                        food_option_id:option.id,
                        id: optionItem.id,
                        quantity: Float(optionItem.quantity),
                        status: optionItem.status)
                    
                    itemNeedToUpdate.order_detail_food_options.append(optionDetail)
                }
            }
            
            itemArrayNeedToUpdate.append(itemNeedToUpdate)
        }
       return itemArrayNeedToUpdate
    }
    
}
