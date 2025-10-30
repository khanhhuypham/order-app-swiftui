//
//  OrderDetailServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//



final class FoodService:FoodServiceProtocol {
 
    func getCategories(branchId:Int,status:Int,categoryType:String) async -> Result<APIResponse<[Category]>, Error>{
        await NetworkManager.callAPIResultAsync(netWorkManger: .categories(
            brand_id: branchId,
            status: status,
            category_types: categoryType
        ))
    }
    
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
    ) async -> Result<APIResponse<FoodResponse>, Error>{
       
        await NetworkManager.callAPIResultAsync(netWorkManger: .foods(
            branch_id: branchId,
            area_id: areaId,
            category_id: categoryId,
            category_type: categoryType,
            is_allow_employee_gift: is_allow_employee_gift,
            is_sell_by_weight: is_sell_by_weight,
            is_out_stock: is_out_stock,
            key_word: key_word,
            limit: limit,
            page:page
        ))
    }

    func addFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<APIResponse<NewOrder>, Error>{
        await NetworkManager.callAPIResultAsync(netWorkManger: .addFoods(
            branch_id: branchId,
            order_id: orderId,
            foods: items,
            is_use_point: DEACTIVE
        ))
    }
    
    func addGiftFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<PlainAPIResponse, Error>{
        await NetworkManager.callAPIResultAsync(netWorkManger:
            .addGiftFoods(
                branch_id: branchId,
                order_id: orderId,
                foods: items,
                is_use_point: ACTIVE
        ))
    }
    
    func createDineInOrder(tableId:Int) async -> Result<APIResponse<Table>, Error>{
        await NetworkManager.callAPIResultAsync(netWorkManger: .openTable(table_id: tableId))
    }
    
    func createTakeOutOder(branchId:Int,tableId:Int,note:String) async -> Result<PlainAPIResponse, Error>{
        await NetworkManager.callAPIResultAsync(netWorkManger: .postCreateOrder(branch_id:branchId, table_id:tableId, note:note))
    }
    
}
