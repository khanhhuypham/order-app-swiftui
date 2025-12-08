//
//  FoodUsecaseProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 8/12/25.
//

protocol FoodUseCaseProtocol {
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> AppResult<[Category]>
    func getFoods(branchId: Int,areaId: Int,parameter: FoodAPIParameter) async -> AppResult<Pagination<[Food]>>
    
    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<NewOrder>
    func addGiftFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<Void>
    func createDineInOrder(tableId: Int) async -> AppResult<Table>
    func createTakeOutOrder(branchId: Int, tableId: Int, note: String) async -> AppResult<Void>
}
