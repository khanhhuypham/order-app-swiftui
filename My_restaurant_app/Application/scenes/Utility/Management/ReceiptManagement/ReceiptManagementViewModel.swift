//
//  ReceiptManagementViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 31/12/2024.
//

import SwiftUI
import AlertToast
import Combine
class ReceiptManagementViewModel: ObservableObject {
    @Injected(\.utils) private var utils
    @Published var orderList:[Order] = []
    @Published var fullList:[Order] = []
    @Published var APIParameter:(
        branch_id:Int,
        userId: Int?,
        status: String,
        key_word:String,
        limit:Int,
        page:Int
    ) = (
        branch_id:0,
        userId: nil,
        status: "2,5",
        key_word:"",
        limit:50,
        page:1
    )
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
            status: APIParameter.status,
            search_key:"",
            branch_id:Constants.branch.id ?? 0,
            limit:APIParameter.limit,
            page:APIParameter.page
        )){result in
            
            switch result {
                case .success(let data):
                    
                    guard let res = try? JSONDecoder().decode(APIResponse<OrderResponse>.self, from: data) else{
                        return
                    }
                
                
                    DispatchQueue.main.async {
                        self.orderList = res.data.list
                        self.fullList = res.data.list
//                        self.utils.toastUtils.alertToast = AlertToast(displayMode: .banner(.pop), type: .complete(.green), title:"Success", subTitle: "Load dữ liệu thành công")
                    }
                
                    

                case .failure(let error):
                    break
//                    self.utils.toastUtils.alertToast = AlertToast(type: .error(.red), title:"Error", subTitle:error.localizedDescription)
              
            }
        }
    }
}
