//
//  OrderDetailViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 12/09/2024.
//

import UIKit
import SwiftUI


enum popupType{
    case note
    case discount
    case edit
    case split
    case cancel
}

class OrderDetailViewModel: ObservableObject {
    
    @Published var order:OrderDetail = OrderDetail()
    
    @Published var selectedItem:OrderItem? = nil
    
    @Published var printItems:[PrintItem] = []
    
    @Published var showpopup:Bool = false
    @Published var showSheet:Bool = false
    @Published var showDialog:Bool = false
    @Published var showingFullScreen:Bool = false
    
    @Published public var showPopup:(
        show:Bool,
        PopupType:popupType,
        item:OrderItem?
    ) = (false,.cancel,nil)
    
    
    
    init(order:Order? = nil){
        if let orderDetail = order{
            self.order = OrderDetail(order: orderDetail)
        }else{
            self.order = OrderDetail()
        }
    }

    func getOrder(){
        
        NetworkManager.callAPI(netWorkManger: .getOrderDetail(order_id: order.id , branch_id: Constants.branch.id ?? 0)){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard var res = try? JSONDecoder().decode(APIResponse<OrderDetail>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                    
                    
                
                    if res.data.buffet != nil{
                        res.data.buffet?.updateTickets()
                    }
                
                    self.order = res.data
                    
                    order.orderItems.removeAll(where: {($0.category_type == .drink || $0.category_type == .other) && $0.quantity == 0})
                
                    
                    self.getFoodsNeedPrint()
                
                
                    //Nếu bàn booking thì sẽ lấy thêm các món ăn
                    if let booking_status = order.booking_status,booking_status == .status_booking_setup{
                        self.getBookingOrder()
                    }
          
                
                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    // Method to increase the quantity of an item
    func setQuantity(for item: OrderItem, quantity:Float) {
        if let index = order.orderItems.firstIndex(where: { $0.id == item.id }) {
            
            order.orderItems[index].setQuantity(quantity: quantity)
            
//            if quantity < 0.01{
//                order.orderItems[index].quantity = item.is_sell_by_weight == ACTIVE ? 0.01 : 1
//            }else{
//                order.orderItems[index].quantity = quantity
//            }

        }
    }
    
    func popupContent(content:any View) -> any View {
        return content
    }
    
    
   
}
extension OrderDetailViewModel{

    func getFoodsNeedPrint(){
        
        NetworkManager.callAPI(netWorkManger: .foodsNeedPrint(order_id: order.id)){[weak self] result in
            guard let self = self else { return }
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[PrintItem]>.self, from: data) else{
                        return
                    }
                    
                    self.printItems = res.data
                 
                
                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    
    func getBookingOrder(){
        
        NetworkManager.callAPI(netWorkManger: .getFoodsBookingStatus(order_id: order.id)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[PrintItem]>.self, from: data) else{
                        return
                    }
                
                    var bookingItems = res.data
             
                    bookingItems.enumerated().forEach{(i,_) in
                        bookingItems[i].is_booking_item = ACTIVE
                    }
                    

                   self.printItems += bookingItems
                 
        

                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    
    //MARK: API Huỷ món
    func cancelItem(item:OrderItem){
        NetworkManager.callAPI(netWorkManger: .cancelFood(
            branch_id: Constants.branch.id ?? 0,
            order_id: order.id,
            reason: item.cancel_reason,
            order_detail_id: item.order_id,
            quantity: Int(item.quantity)))
        {[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        guard let res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                            return
                        }
                        dLog(res)
                
                        break
                

                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    
    
    func discountOrderItem(item:OrderItem) {
        NetworkManager.callAPI(netWorkManger: .postDiscountOrderItem(branch_id: Constants.branch.id ?? 0, orderId: order.id, orderItem: item)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                    guard let res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        return
                    }
                    dLog(res)
                
                    break
                

                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    
    func addNote(orderDetailId:Int,note:String){
        NetworkManager.callAPI(netWorkManger: .addNoteToOrder(branch_id: Constants.branch.id ?? 0, order_detail_id:orderDetailId, note:note)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                    guard let res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        return
                    }
                    dLog(res)
                
                    break
                

                  case .failure(let error):
                      print(error)
            }
        }
      
    }
    
    
    
}
