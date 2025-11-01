//
//  OrderServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//



// MARK: - Data Layer

protocol OrderLogServiceProtocol {
    func getOrderLog(orderId: Int) async -> Result<APIResponse<ActivityLogResponse>, Error>
}


final class OrderLogService: OrderLogServiceProtocol {
    func getOrderLog(orderId: Int) async -> Result<APIResponse<ActivityLogResponse>, Error> {
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


final class OrderLogRepositoryImpl: OrderLogRepository {
    
    private let apiService: OrderLogServiceProtocol
    
    init(apiService: OrderLogServiceProtocol = OrderLogService()) {
        self.apiService = apiService
    }
    
    func fetchOrderLogs(orderId: Int) async -> Result<[ActivityLog], Error> {
        let result = await apiService.getOrderLog(orderId: orderId)
        
        switch result {
            case .success(let response):
                if response.status == .ok, let data = response.data {
                    return .success(data.data)
                } else {
                    return .success([])
                }
            case .failure(let error):
                return .failure(error)
        }
    }
}
