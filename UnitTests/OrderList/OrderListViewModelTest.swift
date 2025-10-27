//
//  OrderListTest.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 17/10/25.
//


import XCTest
@testable import My_restaurant_app

final class OrderListViewModelTests: XCTestCase {
    
    var mockService: MockOrderListService!
    var viewModel: OrderListViewModel!

    override func setUp() {
        super.setUp()
        mockService = MockOrderListService()
        viewModel = OrderListViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_getOrders_success() async {
        var order1 = Order()
        order1.id = 1
        order1.table_name = "A1"
        order1.total_amount = 100

        var order2 = Order()
        order2.id = 2
        order2.table_name = "A2"
        order2.total_amount = 200

        // Create a mock OrderResponse
        let response = OrderResponse(limit: 20,total_record: 100, list: [order1, order2])

        // Specify the generic type explicitly
        let result = APIResponse<OrderResponse>(
             data: response,
             status: .ok,
             message: "success"
        )

        mockService.result = .success(result)

        await viewModel.getOrders(page:1)

        XCTAssertEqual(viewModel.orderList.count, 2)
    }

    func test_closeTable_showsToast() async {
    
        await viewModel.closeTable(id: 1)
//        XCTAssertEqual(mockToast.messages.first, "Huỷ bàn thành công")
    }
    
    func test_getOrderList_success_shouldAppendDataAndIncrementPage() async {
      
        let result = APIResponse<OrderResponse>(
             data: OrderResponse(limit: 20,total_record: 100, list: [Order(), Order()]),
             status: .ok,
             message: "success"
        )
        mockService.result = .success(result)
        
        XCTAssertFalse(viewModel.APIParameter.isAPICalling)
        await viewModel.getOrders(page: 1)

        XCTAssertEqual(viewModel.orderList.count, 2)
        XCTAssertEqual(viewModel.APIParameter.page, 1)
        XCTAssertFalse(viewModel.APIParameter.isAPICalling)
        XCTAssertTrue(viewModel.APIParameter.isGetFullData)
    }
    
    func test_getOrderList_failure_shouldNotAppendData() async {

        mockService.result = .failure(NSError(domain: "", code: -1))
        
        await viewModel.getOrders(page: 1)
        
        XCTAssertEqual(viewModel.orderList.count, 0)
        XCTAssertFalse(viewModel.APIParameter.isAPICalling)
    }
//    
    func test_loadMoreContent_shouldCallAPIWhenNotFullData() async {
        // Arrange
        let list: [Order] = (0...1).map { i in
            var order = Order()
            order.id = i
            return order
        }

        let result = APIResponse<OrderResponse>(
            data: OrderResponse(limit: 20, total_record: 100, list: list),
            status: .ok,
            message: "success"
        )

        // Mock successful API call
        mockService.result = .success(result)

        // Initial setup
        viewModel.APIParameter.isGetFullData = false
        viewModel.APIParameter.page = 1

        // Act: Load first page
        await viewModel.getOrders(page: 1)

        // Verify we have items
        guard let lastOrder = viewModel.orderList.last else {
            XCTFail("Expected orderList to have items")
            return
        }

        // Simulate user reaching the last item twice (pagination trigger)
        await viewModel.loadMoreContent(currentItem: lastOrder)
        
        // Verify we have items
        guard let lastOrder = viewModel.orderList.last else {
            XCTFail("Expected orderList to have items")
            return
        }
        
        await viewModel.loadMoreContent(currentItem: lastOrder)

        // Assert: page number increased correctly
        XCTAssertEqual(viewModel.APIParameter.page, 3)
    }

    func test_clearDataAndCallAPI() async {
        // Given: some existing data
        viewModel.photoList = [
            Photo(id: "1", author: "John", width: 100, height: 100, url: "", download_url: "")
        ]
        viewModel.APIParameter.page = 3
        viewModel.APIParameter.isGetFullData = true
        viewModel.APIParameter.isAPICalling = true

        let photos = [Photo(id: "2", author: "Alice", width: 200, height: 200, url: "", download_url: "")]
        mockService.result = .success(photos)

        viewModel.clearDataAndCallAPI()

        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second

        XCTAssertEqual(viewModel.photoList.count, 1, "Expected one photo after API call")
        XCTAssertEqual(viewModel.photoList.first?.id, "2", "Expected fetched photo ID to match mock data")
        XCTAssertEqual(viewModel.APIParameter.page, 1, "Page should reset to 1 after clear")
    }
}


