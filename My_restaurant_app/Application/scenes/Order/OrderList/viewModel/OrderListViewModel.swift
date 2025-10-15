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

class OrderListViewModel: ObservableObject {
    @Injected(\.utils.toastUtils) var toast
    @Injected(\.utils) private var utils
    
    @Published var orderList:[Order] = []
    
    @Published var fullList:[Order] = []
    
    @Published var selectedOrder:Order? = nil
    
    @Published var APIParameter:(
        branch_id:Int,
        userId: Int,
        order_status: String,
        order_methods:[ORDER_METHOD],
        key_word:String,
        is_take_away:Int
    ) = (
        branch_id:0,
        userId: 0,
        order_status: "0,1,4,6,7",
        order_methods:[.EAT_IN, .TAKE_AWAY,.ONLINE_DELIVERY],
        key_word:"",
        is_take_away:(PermissionUtils.GPBH_1 || PermissionUtils.GPBH_2_o_1) ? ALL : DEACTIVE)
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var presentFullScreen:Bool = false
    @Published public var presentSheet:(show:Bool,action:OrderAction?) = (false,nil)
    
    let socketManager = SocketIOManager.shared
    
    init() {
        $APIParameter
        .map{$0.key_word}
        .removeDuplicates()
        .sink {[weak self]keyWord in
            guard let self = self else { return }
            
            if !keyWord.isEmpty {
                let filteredDataArray = fullList.filter({(value) -> Bool in
                    let str1 = keyWord.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                    let str2 = value.table_name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                    let str3 = String(value.total_amount)
                    return str2.contains(str1) || str3.contains(str1)
                })
                self.orderList = filteredDataArray
            }else{
                self.orderList = fullList
            }
            
        
        }.store(in: &cancellables)
        dLog("init")
    }
    
    deinit{
        dLog("deinit")
    }
    

    @MainActor
    func getOrders() async {
        
        let result: Result<APIResponse<OrderResponse>, Error> = await NetworkManager.callAPIResultAsync(
                netWorkManger: .orders(
                    brand_id: Constants.brand.id,
                    branch_id: Constants.branch.id,
                    userId: 0,
                    order_methods: APIParameter.order_methods.map { $0.rawValue.description }.joined(separator: ","),
                    order_status: APIParameter.order_status
                )
        )
        
        switch result {
            case .success(let res):
                if res.status == .ok  {
                    self.orderList = res.data.list
                    self.fullList = res.data.list
                }
         

            case .failure(let error):
                dLog("❌ Orders API failed: \(error)")
        }
    }


    
    
    func closeTable(id: Int) async {
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .closeTable(order_id: id))
        
        switch result {
            case .success(let res):
                if res.status == .ok{
                    
                    await toast.alertSubject.send(
                        AlertToast(type: .regular, title: "Warning", subTitle: "Huỷ bản thành công")
                    )
                    
                    await getOrders()
                    
                }else{
                    await toast.alertSubject.send(
                        AlertToast(type: .regular, title: "warning", subTitle: res.message)
                    )
                }
              
                
            case .failure(let error):
                dLog("❌ Close table failed: \(error.localizedDescription)")
               
        }
    }


}

enum OrderTypeGroup: CaseIterable {
    case dineIn, appFood

    var title: String {
        switch self {
        case .dineIn: return "Tại bàn"
        case .appFood: return "App Food"
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
