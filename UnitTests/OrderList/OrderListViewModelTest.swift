//
//  OrderListTest.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 17/10/25.
//


import XCTest
@testable import My_restaurant_app

final class OrderListViewModelTests: XCTestCase {
    var sut: OrderListViewModel! // System Under Test
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments = ["-mockLoginAPI"]
        app.launch()
        sut = OrderListViewModel()
    }

    override func tearDown() {
        // Clean up after each test
        app = nil
        sut = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // Test case: The login from valid or not when fields are empty
    func test_close_order() async{
    }
    
 
    
    func test_userTapButton_showsResult() {

        // Tap the button
        app.buttons["Loại đơn"].tap() // open menu
        app.buttons["Mang về"].tap()  // tap menu item by text
        
        dLog(sut.orderList.toJSON())
        XCTAssertEqual(sut.orderList.count, 0)

     }
    

}
