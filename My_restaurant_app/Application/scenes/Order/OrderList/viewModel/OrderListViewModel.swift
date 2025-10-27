//
//  OrderListViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import UIKit
import AlertToast
import Combine
import SocketIO


private class APIParameter {
    var isAPICalling = false
    var isGetFullData = false
    var limit = 20
    var page = 1
    var key_word = ""
    var order_methods:[ORDER_METHOD] = []
    var order_status: String = ""
}

class OrderListViewModel: ObservableObject {
    @Injected(\.utils.toastUtils) var toast
    @Injected(\.utils) private var utils
    let service: OrderServiceProtocol
    
    @Published var orderList:[Order] = []
    
    @Published var selectedOrder:Order? = nil
    
    var splitFood:(from:Table,to:Table)? = nil
    
    var APIParameter:(
        branch_id:Int,
        userId: Int,
        order_status: String,
        order_methods:[ORDER_METHOD],
        key_word:String,
        is_take_away:Int,
        limit:Int,
        page:Int,
        isAPICalling:Bool,
        isGetFullData:Bool
    ) = (
        branch_id:0,
        userId: 0,
        order_status: "0,1,4,6,7",
        order_methods:[.EAT_IN, .TAKE_AWAY,.ONLINE_DELIVERY],
        key_word:"",
        is_take_away:(PermissionUtils.GPBH_1 || PermissionUtils.GPBH_2_o_1) ? ALL : DEACTIVE,
        limit:20,
        page:0,
        isAPICalling:false,
        isGetFullData:false
        
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var presentFullScreen:Bool = false
    @Published public var presentSheet:(show:Bool,action:OrderAction?) = (false,nil)
    
    let socketManager = SocketIOManager.shared
    
    init(service: OrderServiceProtocol = OrderService()) {
        self.service = service
        
//        $APIParameter
//        .map{$0.key_word}
//        .removeDuplicates()
//        .sink {[weak self]keyWord in
//            guard let self = self else { return }
//                
//        }.store(in: &cancellables)

    }
    
    
    @MainActor
    func loadMoreContent(currentItem: Order) async {

        guard !APIParameter.isAPICalling else { return }
        guard !APIParameter.isGetFullData else { return }

        guard let lastItem = orderList.last, lastItem.id == currentItem.id else { return }


        await getOrders(page: APIParameter.page + 1)
    }
    
    @MainActor
    func clearDataAndCallAPI() async{
        orderList.removeAll()
        APIParameter.page = 0
        APIParameter.isGetFullData = false
        APIParameter.isAPICalling = false
        await getOrders(page: APIParameter.page + 1)
    }

    
}




enum OrderTypeGroup: CaseIterable {
    case dineIn, appFood

    var title: String {
        switch self {
            case .dineIn: 
                return "Tại bàn"
            
            case .appFood: 
                return "App Food"
        }
    }

    var methods: [ORDER_METHOD] {
        switch self {
            case .dineIn:
                return [.EAT_IN, .TAKE_AWAY, .ONLINE_DELIVERY]
            case .appFood:
                return [.SHOPEE_FOOD, .GRAB_FOOD, .GO_FOOD, .BE_FOOD]
            }
    }
}
