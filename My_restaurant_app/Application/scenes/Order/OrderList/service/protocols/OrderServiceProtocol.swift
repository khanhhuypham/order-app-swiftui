//
//  OrderServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//


protocol OrderServiceProtocol {
    func fetchOrders(brandId: Int,branchId: Int,userId: Int,orderMethods: String,orderStatus: String,limit:Int,page:Int) async -> Result<APIResponse<OrderResponse>, Error>
    func closeTable(orderId: Int) async -> Result<PlainAPIResponse, Error>
}

