//
//  MockOrderDetailService.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 28/10/25.
//

import XCTest
@testable import My_restaurant_app

final class MockOrderDetailService: OrderDetailServiceProtocol {
    
    func getOrder(orderId: Int, branchId: Int) async -> Result<APIResponse<OrderDetail>, any Error> {
        <#code#>
    }
    
    func getFoodsNeedPrint(orderId: Int) async -> Result<APIResponse<[PrintItem]>, any Error> {
        <#code#>
    }
    
    func getBookingOrder(orderId: Int) async -> Result<APIResponse<[PrintItem]>, any Error> {
        <#code#>
    }
    
    func cancelItem(branchId: Int, orderId: Int, reason: String, orderDetailId: Int, quantity: Int) async -> Result<PlainAPIResponse, any Error> {
        <#code#>
    }
    
    func discountOrderItem(branchId: Int, orderId: Int, orderItem: OrderItem) async -> Result<PlainAPIResponse, any Error> {
        <#code#>
    }
    
    func addNote(branchId: Int, orderDetailId: Int, note: String) async -> Result<PlainAPIResponse, any Error> {
        <#code#>
    }
    
    func updateItems(branchId: Int, orderId: Int, orderItems: [OrderItemUpdate]) async -> Result<PlainAPIResponse, any Error> {
        <#code#>
    }
    


}
