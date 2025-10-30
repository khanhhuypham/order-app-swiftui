//
//  OrderServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//


protocol OrderLogServiceProtocol {
    func getOrderLog(orderId:Int) async -> Result<APIResponse<ActivityLogResponse>, Error>
}

final class OrderLogService: OrderLogServiceProtocol {
    
    func getOrderLog(orderId:Int) async -> Result<APIResponse<ActivityLogResponse>, Error>{
        await NetworkManager.callAPIResultAsync(netWorkManger: .getActivityLog(
            object_id: orderId,
            type: 2,
            key_search: "",
            object_type: "",
            from: "",
            to: "",
            page: 1,
            limit: 500
        ))
    }
}
