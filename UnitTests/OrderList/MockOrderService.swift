//
//  MockOrderService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 27/10/25.
//

@testable import My_restaurant_app

final class MockOrderListService: OrderServiceProtocol {

    var fetchOrdersResult:Result<APIResponse<OrderResponse>, Error>?
    var closeTableResult: Result<PlainAPIResponse, Error>?

    func fetchOrders(brandId: Int,branchId: Int,userId: Int,orderMethods: String,orderStatus: String,limit:Int,page:Int) async -> Result<APIResponse<OrderResponse>, Error> {

        return fetchOrdersResult ?? .success(APIResponse<OrderResponse>(
            data: OrderResponse(limit: limit,total_record: 1000, list: []),
            status: .ok,
            message: "success"
       ))
    }

    func closeTable(orderId: Int) async -> Result<PlainAPIResponse, Error> {
        closeTableResult ?? .success(PlainAPIResponse(status: .ok, message: "Closed"))
    }

}

