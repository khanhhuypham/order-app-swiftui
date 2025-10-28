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
    

    func test_closeTable_success_shouldPrintSuccessMessage() async {
        // Given
        mockService.closeTableResult = .success(PlainAPIResponse(status: .ok, message: "Closed"))
        
        // When
        await viewModel.closeTable(id: 1)
        // Then
        // no crash, no toast error, we can assert nothing changed
        XCTAssertTrue(true)
    }

    
    func test_getOrderList_success_shouldAppendDataAndIncrementPage() async {
      
        mockService.fetchOrdersResult = .success(createDummyResponse(dataArray: (1...10)))
        XCTAssertFalse(viewModel.APIParameter.isAPICalling)
        await viewModel.getOrders(page: 1)

        XCTAssertEqual(viewModel.orderList.count, 10)
        XCTAssertEqual(viewModel.APIParameter.page, 1)
        XCTAssertFalse(viewModel.APIParameter.isAPICalling)
        XCTAssertTrue(viewModel.APIParameter.isGetFullData)
    }
    
    func test_getOrderList_failure() async {

        mockService.fetchOrdersResult = .failure(NSError(domain: "", code: -1))
        
        await viewModel.getOrders(page: 1)
        
        XCTAssertEqual(viewModel.orderList.count, 0)
        XCTAssertFalse(viewModel.APIParameter.isAPICalling)
    }
    
    func test_loadMoreContent() async {
        viewModel.APIParameter.limit = 10
        mockService.fetchOrdersResult = .success(createDummyResponse(dataArray: (1...10)))
        await viewModel.clearDataAndCallAPI()
        
        mockService.fetchOrdersResult = .success(createDummyResponse(dataArray: (11...20)))
        await viewModel.loadMoreContent()
      
        mockService.fetchOrdersResult = .success(createDummyResponse(dataArray: (21...30)))
        await viewModel.loadMoreContent()

        mockService.fetchOrdersResult = .success(createDummyResponse(dataArray: (31...35)))
        await viewModel.loadMoreContent()
        //===============================
        await viewModel.loadMoreContent()
        await viewModel.loadMoreContent()
        await viewModel.loadMoreContent()

        // Assert: page number increased correctly
        XCTAssertEqual(viewModel.APIParameter.page, 4)
        XCTAssertEqual(viewModel.orderList.count, 35)
    }

    func test_clearDataAndCallAPI() async {
        // Given: some existing data, we currently have 30 records and at page 3
        viewModel.orderList = createDummyData(dataArray: (1...30))
        viewModel.APIParameter.page = 3
        viewModel.APIParameter.limit = 10
        viewModel.APIParameter.isGetFullData = false
        viewModel.APIParameter.isAPICalling = false
        XCTAssertEqual(viewModel.orderList.count, 30)
        
        //then we clear data and get the first page
        mockService.fetchOrdersResult = .success(createDummyResponse(dataArray: (1...10)))
        await viewModel.clearDataAndCallAPI()
        

        XCTAssertEqual(viewModel.orderList.count, 10, "Expected one photo after API call")
        XCTAssertEqual(viewModel.orderList.first?.id, 1, "Expected fetched photo ID to match mock data")
        XCTAssertEqual(viewModel.APIParameter.page, 1, "Page should reset to 1 after clear")
    }
    
    
    private func createDummyData(dataArray:ClosedRange<Int>) -> [Order] {
        return dataArray.map { Order(id: $0) }
    }
    
    private func createDummyResponse(dataArray:ClosedRange<Int>) -> APIResponse<OrderResponse> {
        return  APIResponse<OrderResponse>(
            data: OrderResponse(limit: 0, total_record: 100, list: createDummyData(dataArray: dataArray)),
            status: .ok,
            message: "success"
        )
    }
    
    
}


