//
//  MockOrderDetailService.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 28/10/25.
//

import XCTest
@testable import My_restaurant_app
final class MockOrderDetailService: OrderDetailServiceProtocol {

    
    var getOrderResult: Result<APIResponse<OrderDetail>, Error>?
    var getFoodsNeedPrintResult: Result<APIResponse<[PrintItem]>, Error>?
    var updateAlreadyPrintedResult: Result<PlainAPIResponse, Error>?
    var getBookingOrderResult: Result<APIResponse<[PrintItem]>, Error>?
    var cancelItemResult: Result<PlainAPIResponse, Error>?
    var discountOrderItemResult: Result<PlainAPIResponse, Error>?
    var addNoteResult: Result<PlainAPIResponse, Error>?
    var updateItemsResult: Result<PlainAPIResponse, Error>?

    func getOrder(orderId: Int, branchId: Int) async -> Result<APIResponse<OrderDetail>, Error> {
        getOrderResult ?? .failure(MockError.noMockData)
    }
    
    func getFoodsNeedPrint(orderId: Int) async -> Result<APIResponse<[PrintItem]>, Error> {
        getFoodsNeedPrintResult ?? .failure(MockError.noMockData)
    }

    func getBookingOrder(orderId: Int) async -> Result<APIResponse<[PrintItem]>, Error> {
        getBookingOrderResult ?? .failure(MockError.noMockData)
    }
    
    func cancelItem(branchId: Int, orderId: Int, reason: String, orderDetailId: Int, quantity: Int) async -> Result<PlainAPIResponse, Error> {
        cancelItemResult ?? .failure(MockError.noMockData)
    }
    
    func discountOrderItem(branchId: Int, orderId: Int, orderItem: OrderItem) async -> Result<PlainAPIResponse, Error> {
        discountOrderItemResult ?? .failure(MockError.noMockData)
    }
    
    func addNote(branchId: Int, orderDetailId: Int, note: String) async -> Result<PlainAPIResponse, Error> {
        addNoteResult ?? .failure(MockError.noMockData)
    }
    
    func updateItems(branchId: Int, orderId: Int, orderItems: [OrderItemUpdate]) async -> Result<PlainAPIResponse, Error> {
        updateItemsResult ?? .failure(MockError.noMockData)
    }
    
    func updateAlreadyPrinted(orderId: Int, order_detail_ids: [Int]) async -> Result<My_restaurant_app.PlainAPIResponse, any Error> {
        updateAlreadyPrintedResult ?? .failure(MockError.noMockData)
    }
    
    func sendRequestPrintOrderItem(branchId: Int, orderId: Int, printType: Int) async -> Result<My_restaurant_app.PlainAPIResponse, any Error> {
        .failure(MockError.noMockData)
    }
    
    
    enum MockError: Error {
        case noMockData
    }
}
