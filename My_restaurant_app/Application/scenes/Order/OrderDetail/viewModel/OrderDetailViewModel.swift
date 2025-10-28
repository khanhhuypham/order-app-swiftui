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

/*
 ✅ SOLID enough for your current module.
 ✅ Perfect for MVVM — since one ViewModel manages all order details.
 ✅ Simple and pragmatic.
 */
class OrderDetailViewModel: ObservableObject {
    @Injected(\.utils.toastUtils) var toast
    let socketManager = SocketIOManager.shared
    let service: OrderDetailServiceProtocol
    @Published var order:OrderDetail = OrderDetail()
    @Published var printItems:[PrintItem] = []
    
    @Published public var showSheet:(show:Bool,type:OrderAction) = (false,.splitFood)
    @Published public var showPopup:(show:Bool,type:PopupType,item:OrderItem?) = (false,.cancel,nil)
    var splitFood:(from:Table,to:Table)? = nil
    
    
    init(order:Order? = nil,service:OrderDetailServiceProtocol = OrderDetailService()){
        if let orderDetail = order{
            self.order = OrderDetail(order: orderDetail)
        }else{
            self.order = OrderDetail()
        }
        self.service = service
    }
    
    @MainActor
    func getOrder() async{
        
        let result = await service.getOrder(orderId: order.id, branchId: Constants.branch.id)
        
        switch result {
            case .success(let res):
        
                if res.status == .ok,var data = res.data{
                    if data.buffet != nil{
                        data.buffet?.updateTickets()
                    }

                    self.order = data

                    order.orderItems.removeAll(where: {($0.category_type == .drink || $0.category_type == .other) && $0.quantity == 0})

                    await self.getFoodsNeedPrint()

                    //Nếu bàn booking thì sẽ lấy thêm các món ăn
                    if let booking_status = order.booking_status,booking_status == .status_booking_setup{
                        await self.getBookingOrder()
                    }
                }else{
                    toast.alertSubject.send(
                        AlertToast(type: .regular, title: "warning", subTitle: res.message)
                    )
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
        
        
//        let result = await orderService.fetchOrderDetail(orderId: order.id, branchId:  Constants.branch.id)
//        switch result {
//           case .success(let res):
//       
//               if res.status == .ok,var data = res.data{
//                   if data.buffet != nil{
//                       data.buffet?.updateTickets()
//                   }
//
//                   self.order = data
//
//                   order.orderItems.removeAll(where: {($0.category_type == .drink || $0.category_type == .other) && $0.quantity == 0})
//
//                   await self.getFoodsNeedPrint()
//
//                   //Nếu bàn booking thì sẽ lấy thêm các món ăn
//                   if let booking_status = order.booking_status,booking_status == .status_booking_setup{
//                       await self.getBookingOrder()
//                   }
//               }else{
//                   toast.alertSubject.send(
//                       AlertToast(type: .regular, title: "warning", subTitle: res.message)
//                   )
//               }
//
//
//           case .failure(let error):
//              dLog("Error: \(error)")
//       }
    }
    
   


    // Method to increase the quantity of an item
    func setQuantity(for item: OrderItem, quantity:Float) {
        if let index = order.orderItems.firstIndex(where: { $0.id == item.id }) {
            order.orderItems[index].setQuantity(quantity: quantity)
        }
    }
    

   
}
extension OrderDetailViewModel{
    
    @MainActor
    func getFoodsNeedPrint() async{
        let result = await service.getFoodsNeedPrint(orderId: order.id)
        
        switch result {
            case .success(let res):
            
                if res.status == .ok,let data = res.data{
                    self.printItems = data
                }
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }

    @MainActor
    func getBookingOrder() async{
        let result = await service.getBookingOrder(orderId: order.id)
      
        switch result {
            case .success(let res):
            
                if res.status == .ok,var data = res.data{
       

                    data.enumerated().forEach{(i,_) in
                        data[i].is_booking_item = ACTIVE
                    }

                    self.printItems += data
                }
                

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
   
    
    

    
    
    //MARK: API Huỷ món
    @MainActor
    func cancelItem(item:OrderItem,reason:String) async{
        
        let result = await service.cancelItem(branchId: Constants.branch.id, orderId: order.id, reason: reason, orderDetailId: item.id, quantity: Int(item.quantity))
      
        switch result {
            case .success(let res):
                
                if res.status != .ok{
                    await toast.alertSubject.send(
                        AlertToast(type: .regular, title: "warning", subTitle: res.message)
                    )
                }

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    @MainActor
    func discountOrderItem(item:OrderItem) async{
   
        let result = await service.discountOrderItem(branchId: Constants.branch.id, orderId: order.id, orderItem: item)

        switch result {

            case .success(let res):
                if res.status != .ok{
                    dLog(res.message)
                }
                break

                
            case .failure(let error):
               dLog("Error: \(error)")
        }
        
//        let result = await discountService.discountOrderItem(branchId: Constants.branch.id, orderId: order.id, orderItem: item)
//        switch result {
//
//            case .success(let res):
//                if res.status != .ok{
//                    dLog(res.message)
//                }
//                break
//
//
//            case .failure(let error):
//               dLog("Error: \(error)")
//        }
        
    }
    
    @MainActor
    func addNote(orderDetailId:Int,note:String) async{
        
 
        let result = await service.addNote(branchId: Constants.branch.id, orderDetailId: orderDetailId, note: note)
    
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
        
//        let result = await noteService.addNote(branchId: Constants.branch.id, orderDetailId: orderDetailId, note: note)
//        
//        switch result {
//
//            case .success(let res):
//                if res.status != .ok{
//                    await toast.alertSubject.send(
//                        AlertToast(type: .regular, title: "warning", subTitle: res.message)
//                    )
//                }
//                break
//
//
//            case .failure(let error):
//               dLog("Error: \(error)")
//
//        }
//        
        

    }
    
    
    @MainActor
    func updateItems() async{
        let orderItemsUpdate = repairUpdateFoods(items: order.orderItems)
        
    
        let result = await service.updateItems(branchId: Constants.branch.id, orderId: order.id, orderItems: orderItemsUpdate)
        
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
