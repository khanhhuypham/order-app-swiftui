//
//  OrderListViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import UIKit
import AlertToast
import Combine
class OrderListViewModel: ObservableObject {

    @Injected(\.utils) private var utils
    @Published var orderList:[Order] = []
    
    @Published var fullList:[Order] = []
    
    @Published var APIParameter:(
        branch_id:Int,
        userId: Int,
        order_status: String,
        key_word:String,
        is_take_away:Int
    ) = (
        branch_id:0,
        userId: 0,
        order_status: "",
        key_word:"",
        is_take_away:(PermissionUtils.GPBH_1 || PermissionUtils.GPBH_2_o_1) ? ALL : DEACTIVE)
    private var cancellables = Set<AnyCancellable>()
    
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
        
     
    }
    

    func getOrders(){
       
        NetworkManager.callAPI(netWorkManger: .orders(
                        userId: APIParameter.userId,
                        order_status: APIParameter.order_status,
                        key_word:"",
                        branch_id:Constants.branch.id ?? 0,
                        is_take_away:APIParameter.is_take_away))
        {result in
            
            switch result {
                case .success(let data):
                    
                    guard let res = try? JSONDecoder().decode(APIResponse<[Order]>.self, from: data) else{
                        return
                    }
                
                
                    DispatchQueue.main.async {
                        self.orderList = res.data
                        self.fullList = res.data
//                        self.utils.toastUtils.alertToast = AlertToast(displayMode: .banner(.pop), type: .complete(.green), title:"Success", subTitle: "Load dữ liệu thành công")
                    }
                
                    

                case .failure(let error):
                    break
//                    self.utils.toastUtils.alertToast = AlertToast(type: .error(.red), title:"Error", subTitle:error.localizedDescription)
              
            }
        }
    }
}
