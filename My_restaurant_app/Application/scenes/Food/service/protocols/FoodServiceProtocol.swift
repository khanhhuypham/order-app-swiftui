//
//  OrderDetailServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//



protocol FoodServiceProtocol {
    
    func getCategories(branchId:Int,status:Int,categoryType:String) async -> Result<APIResponse<[Category]>, Error>
    
    func getFoods(
        branchId:Int,
        areaId:Int,
        categoryId:Int,
        categoryType:Int,
        is_allow_employee_gift:Int,
        is_sell_by_weight:Int,
        is_out_stock:Int,
        key_word:String,
        limit:Int,
        page:Int
    ) async -> Result<APIResponse<FoodResponse>, Error>
    
    func addFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<APIResponse<NewOrder>, Error>
    func addGiftFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<PlainAPIResponse, Error>
    func createDineInOrder(tableId:Int) async -> Result<APIResponse<Table>, Error>
    func createTakeOutOder(branchId:Int,tableId:Int,note:String) async -> Result<PlainAPIResponse, Error>
    
}
