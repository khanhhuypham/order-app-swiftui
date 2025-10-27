//
//  MockOrderService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 27/10/25.
//

@testable import My_restaurant_app

final class MockOrderListService: OrderServiceProtocol {

    var result:Result<APIResponse<OrderResponse>, Error>?

    func fetchOrders(brandId: Int,branchId: Int,userId: Int,orderMethods: String,orderStatus: String,limit:Int,page:Int) async -> Result<APIResponse<OrderResponse>, Error> {

        // Create a mock OrderResponse
        let response = OrderResponse(limit: 20,total_record: 0, list: [])

        // Specify the generic type explicitly
        let r = APIResponse<OrderResponse>(
             data: response,
             status: .ok,
             message: "success"
        )
        
        return result ?? .success(r)
    }

    func closeTable(orderId: Int) async -> Result<PlainAPIResponse, Error> {
        .success(PlainAPIResponse(status: .ok, message: "Closed"))
    }
}

