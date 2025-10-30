//
//  OrderListTest.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 17/10/25.
//


import XCTest
@testable import My_restaurant_app

final class OrderDetailViewModelTests: XCTestCase {
    
    var mockService: MockOrderDetailService!
    var viewModel: OrderDetailViewModel!

    override func setUp() {
        super.setUp()
        mockService = MockOrderDetailService()
        viewModel = OrderDetailViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    
    //========================= get items need to print ==============================
    
   func test_getFoodsNeedPrint_shouldFilterAndPrintCorrectly() async{
       
        mockService.getFoodsNeedPrintResult = .success(
            APIResponse(
                data:createDummyData(dataArray: (1...3)),
                status: .ok,
                message: "ok"
            )
        )
  
       // When
       await viewModel.getFoodsNeedPrint()
       // Then
       XCTAssertEqual(viewModel.printItems.count, 3)
       
       mockService.updateAlreadyPrintedResult = .success(createDummyPlainResponse())
       await viewModel.getFoodsNeedPrint(print: true)
       try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
       XCTAssertEqual(viewModel.printItems.count, 0)
   }
    //========================= update item ==============================
    //🔹 Unit tests
    func test_repairUpdateFoods_shouldMapCorrectly() {
        var fakeItem = OrderItem()
        fakeItem.id = 1
        fakeItem.quantity = 5
        fakeItem.isChange = true

        let result = viewModel.repairUpdateFoods(items: [fakeItem])
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.order_detail_id, 1)
        XCTAssertEqual(result.first?.quantity, 5)
    }

    //🔹 Integration tests
    func test_updateItems_successfully() async {
        var item = OrderItem()
        item.quantity = 5
        item.isChange = true
        viewModel.order.orderItems = [item]
        
        // When
        mockService.updateItemsResult = .success(createDummyPlainResponse())
        await viewModel.updateItems()
        
        if let foundItem = viewModel.order.orderItems.first{
            XCTAssertEqual(foundItem.quantity, 5)
            XCTAssertFalse(foundItem.isChange)
        }
       
    }
    
    func test_updateItems_shouldHandleFailure() async {
        var item = OrderItem()
        item.id = 1
        item.quantity = 2
        item.note = "Add cheese"
        item.price = 150
        item.discount_percent = 5
        item.isChange = true
        viewModel.order.orderItems = [item]
        // When
        mockService.updateItemsResult = .failure(NSError(domain: "test", code: 400))
        await viewModel.updateItems()
    }
    
    //========================= note ==============================
    func test_addNote_Successfully() async {
        var item = OrderItem()
        item.note = "Add cheese"
        viewModel.order.orderItems = [item]
        // When
        mockService.addNoteResult = .success(createDummyPlainResponse())
        await viewModel.addNote(item: item, note: "No onion")
        // Then
        XCTAssertEqual(viewModel.order.orderItems.first?.note, "No onion")
    }
    
    func test_addNote_fail() async {
        var item = OrderItem()
        item.note = "Add cheese"
        viewModel.order.orderItems = [item]
        mockService.addNoteResult = .failure(NSError(domain: "test", code: 400))
        await viewModel.addNote(item: item, note: "No onion")
    }
    
    
    //========================= discount==============================
    func test_discountItem_successfully() async {
        var item = OrderItem()
        item.discount_percent = 10
        viewModel.order.orderItems = [item]
        mockService.updateItemsResult = .success(createDummyPlainResponse())
        await viewModel.discountOrderItem(item: item)

        XCTAssertEqual(viewModel.order.orderItems.first?.discount_percent, 10)
    }

    func test_discountItem_fail() async {
        var item = OrderItem()
        item.discount_percent = 10
        viewModel.order.orderItems = [item]
        mockService.discountOrderItemResult = .failure(NSError(domain: "test", code: 400))
        await viewModel.discountOrderItem(item: item)
    }


    //========================= cancel item ==============================
    func test_cancelItem_successfully() async {
        var item = OrderItem()
        item.id = 1
        item.status = .pending
        viewModel.order.orderItems = [item]
        
        // When
        mockService.cancelItemResult = .success(createDummyPlainResponse())
        await viewModel.cancelItem(item: item, reason: "No longer needed")
        // Then
        XCTAssertEqual(viewModel.order.orderItems.first?.status, .cancel)
    }
    
    func test_cancelItem_fail() async {
        var item = OrderItem()
        item.status = .pending
        viewModel.order.orderItems = [item]
        
        // When
        mockService.cancelItemResult = .failure(NSError(domain: "test", code: 400))
        await viewModel.cancelItem(item: item, reason: "No longer needed")
        // Then
    }

    
    private func createDummyData(dataArray:ClosedRange<Int>) -> [PrintItem] {
        return dataArray.map { i in
            var item = PrintItem()
            item.id = i
            item.name = String(format: "Món %d", i)
            item.printer_id = i
            item.status = i%2 == 0 ? .cancel : .pending
            return item
        }
    }
    
    
    
    private func createDummyPlainResponse() -> PlainAPIResponse {
        return  PlainAPIResponse(
            status: .ok,
            message: "success"
        )
    }
    
}


