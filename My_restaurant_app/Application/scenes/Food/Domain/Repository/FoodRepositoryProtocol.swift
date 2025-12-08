//
//  FoodRepositoryProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 3/12/25.
//



protocol FoodProviderRepositoryProtocol {       // Public API
    func getCategories(branchId:Int,status:Int,categoryType:String) async -> Result<[Category], Error>
    func getFoods(branchId:Int,areaId:Int,parameter:FoodAPIParameter) async -> Result<Pagination<[Food]>, Error>
}


protocol FoodServiceRepositoryProtocol {          // Calls Local DB only
    func addFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<NewOrder, Error>
    func addGiftFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<PlainAPIResponse, Error>
    func createDineInOrder(tableId:Int) async -> Result<Table, Error>
    func createTakeOutOder(branchId:Int,tableId:Int,note:String) async -> Result<Void, Error>
}
