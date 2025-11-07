//
//  FoodViewModelTests.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 1/11/25.
//


import XCTest
@testable import My_restaurant_app

@MainActor
class FoodViewModelTests: XCTest {

    var mockUseCase: MockFoodUseCase!
    var viewModel: FoodViewModel!
    

    override func setUp() {
        super.setUp()
        mockUseCase = MockFoodUseCase()
        viewModel = FoodViewModel(useCase: mockUseCase)
    }
    
    override func tearDown() {
        mockUseCase = MockFoodUseCase()
        viewModel = nil
        super.tearDown()
    }
    
    func test_getCategories_shouldUpdateCategoriesAndReloadContent() async {
        // Given

        mockUseCase.getCategoriesResult = .success(createDummyCategory(dataArray: (1...3)))
  

        // When
        await viewModel.getCategories()
        
        // Then
        XCTAssertEqual(viewModel.categories.first?.name, "category 1")
        XCTAssertEqual(viewModel.categories.count, 3) // includes "Tất cả" + Pizza
        //before reload content, food list will be remove all, and page set to 1
        XCTAssertTrue(viewModel.foods.isEmpty)
        XCTAssertEqual(viewModel.APIParameter.page, 1)
    }
    
    func test_getFoods_shouldAppendFoodsAndSetTotalRecord() async {
   
        mockUseCase.getFoodsResult = .success(FoodResponse(total_record: 100, limit: 20, list: createDummyFood(dataArray: (1...20))))
        
        await viewModel.getFoods()
     
        XCTAssertEqual(viewModel.foods.count, 20)
        XCTAssertEqual(viewModel.APIParameter.total_record, 100)
    }
    
    
    func test_addFoods_shouldSetNavigateTag() async {
        let newOrder = NewOrder(order_id: 888)
        mockUseCase.addFoodsResult = .success(newOrder)

        await viewModel.addFoods(items: [])
        
        XCTAssertEqual(viewModel.order.id, 888)
        XCTAssertEqual(viewModel.navigateTag, 0)
    }
    
    func test_addGiftFoods_shouldSetNavigateTag() async {

        mockUseCase.addGiftFoodsResult = .success(())

        await viewModel.addGiftFoods(items: [])
        
        XCTAssertEqual(viewModel.navigateTag, 0)
    }

    func test_createDineInOrder_shouldUpdateOrderAndNavigate() async {
        let table = Table(id: 1, name: "VIP", status: .using)
        mockUseCase.createDineInOrderResult = .success(table)
        viewModel.order = OrderDetail(table: table)
        
        await viewModel.createDineInOrder()
        
        XCTAssertEqual(viewModel.order.table_id, 1)
        XCTAssertEqual(viewModel.order.table_name, "VIP")
        XCTAssertEqual(viewModel.navigateTag, 1)
    }
    
    
//    func test_processToAddFood_shouldCallAddGiftFoodsWhenFlagSet() async {
//        // Given
//        let food = Food(id: 5, name: "Steak", quantity: 2, isSelect: true)
//        viewModel.selectedFoods = [food]
//        viewModel.APIParameter.is_allow_employee_gift = 1
//        
//        var addGiftFoodsCalled = false
//        mockUseCase.addGiftFoodsResult = .success(())
//        
//        // Spy by subclassing
//        class SpyViewModel: FoodViewModel {
//            var addGiftFoodsCalled = false
//            override func addGiftFoods(items: [FoodRequest]) async {
//                addGiftFoodsCalled = true
//            }
//        }
//        
//        let spy = SpyViewModel(useCase: MockFoodUseCase())
//        spy.selectedFoods = [food]
//        spy.APIParameter.is_allow_employee_gift = 1
//        
//        // When
//        spy.processToAddFood()
//        
//        // Then
//        XCTAssertTrue(spy.addGiftFoodsCalled)
//    }

    private func createDummyCategory(dataArray:ClosedRange<Int>) -> [My_restaurant_app.Category] {
        return dataArray.map { i in
            var cate = Category()
            cate.id = i
            cate.name = String(format: "category %d", i)
            return cate
        }
    }
    
    
    private func createDummyFood(dataArray:ClosedRange<Int>) -> [Food] {
        return dataArray.map { i in
            var food = Food()
            food.id = i
            food.name = String(format: "food %d", i)
            return food
        }
    }
    
}
