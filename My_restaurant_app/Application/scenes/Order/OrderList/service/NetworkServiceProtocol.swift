//
//  NetworkServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 27/10/25.
//


protocol OrderServiceProtocol {
    func fetchOrders(brandId: Int,branchId: Int,userId: Int,orderMethods: String,orderStatus: String,limit:Int,page:Int) async -> Result<APIResponse<OrderResponse>, Error>
    func closeTable(orderId: Int) async -> Result<PlainAPIResponse, Error>
}

protocol ToastUtilsProtocol {
    func show(_ message: String)
}

protocol SocketManagerProtocol {
    func joinRoom()
    func leaveRoom()
}


final class OrderService: OrderServiceProtocol {
    func fetchOrders(brandId: Int,branchId: Int,userId: Int,orderMethods: String,orderStatus: String,limit:Int,page:Int) async -> Result<APIResponse<OrderResponse>, Error> {
        await NetworkManager.callAPIResultAsync(
            netWorkManger: .orders(
                brand_id: brandId,
                branch_id: branchId,
                userId: userId,
                order_methods: orderMethods,
                order_status: orderStatus,
                limit:limit,
                page: page
            )
        )
    }

    func closeTable(orderId: Int) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .closeTable(order_id: orderId))
    }
}
