import Foundation
protocol FoodUseCaseProtocol {
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> AppResult<[Category]>
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
    
    
    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<NewOrder>
    func addGiftFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<Void>
    func createDineInOrder(tableId: Int) async -> AppResult<Table>
    func createTakeOutOrder(branchId: Int, tableId: Int, note: String) async -> AppResult<Void>
}



final class FoodUseCase: FoodUseCaseProtocol {
    
    private let repository: FoodRepositoryProtocol
    
    init(repository: FoodRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> AppResult<[Category]>{
        
        let result = await repository.getCategories(branchId: branchId, status: status, categoryType: categoryType)
        
        switch result {
            
            case .success(let data):
                return .success(data) // data can be nil if repository returns nil
            
            case .failure(let error as NSError):
            
                if error.code == 400 {
                    return .failure(error) // real error
                }

                if error.code > 500 {
                    print("🔥 Server error \(error.code): \(error.localizedDescription)")
                    return .failure(nil) // your "nil error" case
                }

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
    
    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<NewOrder> {
        let result = await repository.addFoods(branchId: branchId, orderId: orderId, items: items)
        
        switch result {
            case .success(let res):
                if res.status == .ok, let data = res.data {
                   return .success(data)
                } else if res.status == .badRequest {
                   let error = NSError(domain: res.message, code: res.status.rawValue)
                   return .failure(error)
                } else {
                   // Other status (e.g., server error > 500)
                   return .failure(nil)
                }
             
            case .failure(let error):
                return .failure(nil)
        }
        
    }
    
    func addGiftFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<Void> {

        let result = await repository.addGiftFoods(branchId: branchId, orderId: orderId, items: items)

        switch result {

        case .success(let res):
            if res.status == .ok {
                return .success(nil)  // Void success
            } else {
                let error = NSError(domain: res.message, code: res.status.rawValue)
                return .failure(error)
            }

        case .failure(let error):
            dLog(error)
            return .failure(nil)  // server error or unknown
        }
    }

    
    func createDineInOrder(tableId: Int) async -> AppResult<Table> {
        
        let result = await repository.createDineInOrder(tableId: tableId)
        
        switch result {
            case .success(let table):
                return .success(table)
            
            case .failure(let error as NSError):
                if error.code == 400 {
                    return .failure(error) // real error
                }

                if error.code > 500 {
                    print("🔥 Server error \(error.code): \(error.localizedDescription)")
                    return .failure(nil) // your "nil error" case
                }

                return .failure(nil)
        }
    }
    
    func createTakeOutOrder(branchId: Int, tableId: Int, note: String) async -> AppResult<Void>{
        let result = await repository.createTakeOutOder(branchId: branchId, tableId: tableId, note: note)
        switch result {
            case .success(let res):
                if res.status == .ok{
                    return .success(nil)
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
            
            case .failure(let error):
                return .failure(error)
        }
    }
}
