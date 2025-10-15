//
//  PaymentViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 30/8/25.
//

import SwiftUI


class PaymentViewModel: ObservableObject {
    let socketManager = SocketIOManager.shared
    @Published var order:OrderDetail = OrderDetail()
        
    @Published var printItems:[PrintItem] = []
    
    @Published public var showPopup:(show:Bool,item:OrderItem?) = (false,nil)
    
    init(order:OrderDetail? = nil){
        if let order = order{
            self.order = order
        }else{
            self.order = OrderDetail()
        }
    }
    
  

    func getOrder(){
        let food_status = String(format: "%d,%d,%d",FOOD_STATUS.pending.rawValue, FOOD_STATUS.cooking.rawValue, FOOD_STATUS.done.rawValue)
        NetworkManager.callAPI(netWorkManger: .order(order_id: order.id, branch_id: Constants.branch.id ?? 0,is_print_bill: ACTIVE, food_status: food_status)){[weak self] (result: Result<APIResponse<OrderDetail>, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {

                case .success(var res):
                
                    if res.status == .ok{
                        if res.data.buffet != nil{
                            res.data.buffet?.updateTickets()
                        }

                        self.order = res.data

                        order.orderItems.removeAll(where: {($0.category_type == .drink || $0.category_type == .other) && $0.quantity == 0})

                
                    }
                    

                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
   
   
}
