//
//  FoodRepository.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 31/10/25.
//

import UIKit


final class FoodRemoteRepo:FoodProviderRepositoryProtocol,FoodServiceRepositoryProtocol {
 
    func getCategories(branchId:Int,status:Int,categoryType:String) async -> Result<[Category], Error>{
        
        let result:Result<APIResponse<[Category]>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .categories(
            brand_id: branchId,
            status: status,
            category_types: categoryType
        ))
        
        switch result {
            
            case .success(let response):
                
                if response.status == .ok{
                    return .success(response.data ?? [])
                }
            
                return .failure(NSError(domain: response.message, code:response.status.rawValue))
                
            case .failure(let error):
                return .failure(NSError(domain: error.localizedDescription, code:500))
        }
        
        
    }
    
    func getFoods(branchId:Int,areaId:Int,parameter:FoodAPIParameter) async -> Result<Pagination<[Food]>, Error>{
       
        let result:Result<APIResponse<Pagination<[Food]>>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .foods(
            branch_id: branchId,
            area_id: areaId,
            category_id: parameter.categoryId,
            category_type: parameter.categoryType.rawValue,
            is_allow_employee_gift: parameter.isAllowEmployeeGift,
            is_sell_by_weight: parameter.isSellByWeight,
            is_out_stock: parameter.isOutStock,
            key_word: parameter.keyWord,
            limit: parameter.limit,
            page: parameter.page
        ))
        
        switch result {
            
            case .success(let response):
                
                if response.status == .ok, let data = response.data{
                    return .success(data)
                }
            
                return .failure(NSError(domain: response.message, code:response.status.rawValue))
            
            case .failure(let error):
                return .failure(NSError(domain: error.localizedDescription, code:500))
        }
        
        
        
    }

    func addFoods(branchId:Int,orderId:Int,items:[FoodRequest]) async -> Result<NewOrder, Error>{
        let result:Result<APIResponse<NewOrder>,Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .addFoods(
            branch_id: branchId,
            order_id: orderId,
            foods: items,
            is_use_point: DEACTIVE
        ))
        
        switch result {
            
            case .success(let response):
                
                if response.status == .ok, let data = response.data{
                    return .success(data)
                }
            
                return .failure(NSError(domain: response.message, code:response.status.rawValue))
            
            case .failure(let error):
                return .failure(NSError(domain: error.localizedDescription, code:500))
        }
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
    
    func createDineInOrder(tableId:Int) async -> Result<Table, Error>{
        let result:Result<APIResponse<Table>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .openTable(table_id: tableId))
        
        switch result {
            
            case .success(let response):
                
                if response.status == .ok, let data = response.data{
                    return .success(data)
                }
            
                return .failure(NSError(domain: response.message, code:response.status.rawValue))
                
            case .failure(let error):
                return .failure(NSError(domain: error.localizedDescription, code:500))
        }
        
    }
    
    func createTakeOutOder(branchId:Int,tableId:Int,note:String) async -> Result<Void, Error>{
        
        let result:Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .postCreateOrder(branch_id:branchId, table_id:tableId, note:note))
        
        switch result {
            
            case .success(let response):
                
                if response.status == .ok{
                    return .success(())
                }
                return .failure(NSError(domain: response.message, code:response.status.rawValue))
            
            case .failure(let error):
                return .failure(NSError(domain: error.localizedDescription, code:500))
        }
    }
    
}
