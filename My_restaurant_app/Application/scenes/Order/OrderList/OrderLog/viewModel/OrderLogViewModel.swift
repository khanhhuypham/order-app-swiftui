//
//  OrderLogViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//

import SwiftUI

class OrderLogViewModel: ObservableObject {
    let service: OrderLogServiceProtocol
    @Published public var dataArray:[ActivityLog] = []
    @Published var searchKey = ""
    init(service: OrderLogServiceProtocol = OrderLogService()) {
        self.service = service
   
    }
    
    
    @MainActor
    func getOrderLog(orderId:Int)async{

        let result = await service.getOrderLog(orderId: orderId)
  
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
