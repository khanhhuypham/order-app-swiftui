//
//  MockFoodUseCase.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 1/11/25.
//



@testable import My_restaurant_app

final class MockFoodUseCase: FoodUseCaseProtocol {
    // MARK: - Mock return values
    var getCategoriesResult: Result<[Category], Error> = .success([])
    var getFoodsResult: Result<FoodResponse, Error> = .success(FoodResponse(total_record: 0, limit: 20, list: []))
    var addFoodsResult: Result<NewOrder, Error> = .success(NewOrder(order_id: 100))
    var addGiftFoodsResult: Result<Void, Error> = .success(())
    var createDineInOrderResult: Result<Table, Error> = .success(Table(id: 1, name: "Table 1", status: .using))
    var createTakeOutOrderResult: Result<Void, Error> = .success(())
    
    // MARK: - FoodUseCaseProtocol stubs
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> Result<[Category], Error> {
        return getCategoriesResult
    }

    func getFoods(branchId: Int, areaId: Int, categoryId: Int, categoryType: Int, is_allow_employee_gift: Int, is_sell_by_weight: Int, is_out_stock: Int, key_word: String, limit: Int, page: Int) async -> Result<FoodResponse, Error> {
        return getFoodsResult
    }

    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> Result<NewOrder, Error> {
        return addFoodsResult
    }

    func addGiftFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> Result<Void, Error> {
        return addGiftFoodsResult
    }

    func createDineInOrder(tableId: Int) async -> Result<Table, Error> {
        return createDineInOrderResult
    }

    func createTakeOutOrder(branchId: Int, tableId: Int, note: String) async -> Result<Void, Error> {
        return createTakeOutOrderResult
    }
}
