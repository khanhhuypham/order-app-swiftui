//
//  OrderLogViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//

import SwiftUI

class OrderLogViewModel: ObservableObject {
    

    @Published public var dataArray:[ActivityLog] = []
    
    @Published var searchKey = ""
    
    @MainActor
    func getOrderLog(orderId:Int)async{

        let result:Result<APIResponse<ActivityLogResponse>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getActivityLog(
            object_id: orderId,
            type: 2,
            key_search: "",
            object_type: "",
            from: "",
            to: "",
            page: 1,
            limit: 500
        ))
  
            switch result {

                case .success(let res):
                    if res.status == .ok,let data = res.data{
                        self.dataArray = data.data
                    }
                
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        
    }
    
    
 
}
