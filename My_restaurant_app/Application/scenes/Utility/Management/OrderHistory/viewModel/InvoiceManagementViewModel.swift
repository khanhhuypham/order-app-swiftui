//
//  AreaManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

class OrderHistoryViewModel: ObservableObject {

    
     var APIParameter:(
        brand_id:Int,
        branch_id:Int,
        report_type:REPORT_TYPE,
        from_date:String,
        to_date:String,
        key_search:String,
        limit:Int,
        page:Int,
        isGetFullData:Bool
    ) = (
        brand_id: Constants.brand.id,
        branch_id: Constants.branch.id,
        report_type:.today,
        from_date:REPORT_TYPE.today.from_date,
        to_date:REPORT_TYPE.today.to_date,
        key_search:"",
        limit:20,
        page:1,
        isGetFullData:false
    )
    
    @Published var invoiceList:[Order] = []
    
    @Published var orderStatstic:OrderStatistic = OrderStatistic()
    @Published var totalOrder:Int = 0
    
    func getInvoiceList() async{
        let result:Result<APIResponse<OrderResponse>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger:
            .ordersHistory(
                brand_id:APIParameter.brand_id,
                branch_id:APIParameter.branch_id,
                from_date:APIParameter.from_date,
                to_date:APIParameter.to_date,
                order_status: String(format: "%d,%d,%d", ORDER_STATUS_COMPLETE, ORDER_STATUS_DEBT_COMPLETE, ORDER_STATUS_CANCEL),
                limit: APIParameter.limit,
                page: APIParameter.page,
                key_search: APIParameter.key_search
        ))
        
        switch result {

            case .success(let res):
                if res.status == .ok,let data = res.data{
                
                    self.invoiceList = data.list
                    self.totalOrder = data.total_record
                }
                    
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    func getTotalAmountOfOrders() async{
        let result:Result<APIResponse<OrderStatistic>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger:
            .getTotalAmountOfOrders(
                restaurant_brand_id: APIParameter.brand_id,
                branch_id: APIParameter.branch_id,
                order_status: String(format: "%d,%d,%d", ORDER_STATUS_COMPLETE, ORDER_STATUS_DEBT_COMPLETE, ORDER_STATUS_CANCEL),
                key_search:APIParameter.key_search,
                from_date:APIParameter.from_date,
                to_date:APIParameter.to_date
        ))
        switch result {

            case .success(let res):
                if res.status == .ok,let data = res.data{
                    
                    orderStatstic = data
                }
                    
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    

    
}
