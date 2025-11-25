import Foundation
protocol FoodUseCaseProtocol {
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> Result<[Category], Error>
    func getFoods(
        branchId: Int,
        areaId: Int,
        categoryId: Int,
        categoryType: Int,
        is_allow_employee_gift: Int,
        is_sell_by_weight: Int,
        is_out_stock: Int,
        key_word: String,
        limit: Int,
        page: Int
    ) async -> Result<FoodResponse, Error>
    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> Result<NewOrder, Error>
    func addGiftFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> Result<Void, Error>
    func createDineInOrder(tableId: Int) async -> Result<Table, Error>
    func createTakeOutOrder(branchId: Int, tableId: Int, note: String) async -> Result<Void, Error>
}

final class FoodUseCase: FoodUseCaseProtocol {
    
    private let repository: FoodRepositoryProtocol
    
    init(repository: FoodRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> Result<[Category], Error> {
        let result = await repository.getCategories(branchId: branchId, status: status, categoryType: categoryType)
        switch result {
            
            case .success(let response):
                return .success(response.data ?? [])
            
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func getFoods(
        branchId: Int,
        areaId: Int,
        categoryId: Int,
        categoryType: Int,
        is_allow_employee_gift: Int,
        is_sell_by_weight: Int,
        is_out_stock: Int,
        key_word: String,
        limit: Int,
        page: Int
    ) async -> Result<FoodResponse, Error> {
        let result = await repository.getFoods(
            branchId: branchId,
            areaId: areaId,
            categoryId: categoryId,
            categoryType: categoryType,
            is_allow_employee_gift: is_allow_employee_gift,
            is_sell_by_weight: is_sell_by_weight,
            is_out_stock: is_out_stock,
            key_word: key_word,
            limit: limit,
            page: page
        )
        switch result {
            case .success(let res):
                if res.status == .ok, let data = res.data{
                    return .success(data)
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
             
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> Result<NewOrder, Error> {
        let result = await repository.addFoods(branchId: branchId, orderId: orderId, items: items)
        switch result {
            case .success(let res):
                if res.status == .ok,let data = res.data{
                    return .success(data)
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
             
            
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func addGiftFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> Result<Void, Error> {
        let result = await repository.addGiftFoods(branchId: branchId, orderId: orderId, items: items)
        switch result {
            case .success(let res):
                if res.status == .ok{
                    return .success(())
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
           
            
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func createDineInOrder(tableId: Int) async -> Result<Table, Error> {
        let result = await repository.createDineInOrder(tableId: tableId)
        switch result {
            case .success(let res):
                if res.status == .ok,let data = res.data{
                    return .success(data)
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
            
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func createTakeOutOrder(branchId: Int, tableId: Int, note: String) async -> Result<Void, Error> {
        let result = await repository.createTakeOutOder(branchId: branchId, tableId: tableId, note: note)
        switch result {
            case .success(let res):
                if res.status == .ok{
                    return .success(())
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
            
            case .failure(let error):
                return .failure(error)
        }
    }
}
