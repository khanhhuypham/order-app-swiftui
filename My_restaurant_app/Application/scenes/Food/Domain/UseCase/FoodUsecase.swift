import Foundation





final class FoodUseCase: FoodUseCaseProtocol {
    

    private let localFoodProviderRepo: FoodProviderRepositoryProtocol
    private let remoteFoodProviderRepo: FoodProviderRepositoryProtocol
    private let foodServiceRepo: FoodServiceRepositoryProtocol
    
    init(
        foodProviderLocalRepo:FoodProviderRepositoryProtocol,
        foodProviderRemoteRepo: FoodProviderRepositoryProtocol,
        foodServiceRepo:FoodServiceRepositoryProtocol
    ){
        self.localFoodProviderRepo = foodProviderLocalRepo
        self.remoteFoodProviderRepo = foodProviderRemoteRepo
        self.foodServiceRepo = foodServiceRepo
    }
    
    func getCategories(branchId: Int, status: Int, categoryType: String) async -> AppResult<[Category]>{
        
        let result = await remoteFoodProviderRepo.getCategories(branchId: branchId, status: status, categoryType: categoryType)
        
        switch result {
            
            case .success(let data):
            
                return .success(data) // data can be nil if repository returns nil
            
            case .failure(let error as NSError):
            
                if error.code >= 500 {
                    print("🔥 Server error \(error.code): \(error.localizedDescription)")
                    return .failure(nil) // your "nil error" case
                }

                return .failure(error)
                
        }
        
    }
    
    func getFoods(branchId: Int, areaId: Int,parameter: FoodAPIParameter) async -> AppResult<Pagination<[Food]>> {
        
        let result = await remoteFoodProviderRepo.getFoods(branchId: branchId,areaId: areaId,parameter:parameter)
        switch result {
            case .success(let data):
                return .success(data)
          
            case .failure(let error as NSError):
            
                if error.code >= 500 {
                    print("🔥 Server error \(error.code): \(error.localizedDescription)")
                    return .failure(nil) // your "nil error" case
                }

                return .failure(error)
        }
    }
    
    func addFoods(branchId: Int, orderId: Int, items: [FoodRequest]) async -> AppResult<NewOrder> {
        let result = await foodServiceRepo.addFoods(branchId: branchId, orderId: orderId, items: items)
        
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

        let result = await foodServiceRepo.addGiftFoods(branchId: branchId, orderId: orderId, items: items)

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
        
        let result = await foodServiceRepo.createDineInOrder(tableId: tableId)
        
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
        let result = await foodServiceRepo.createTakeOutOder(branchId: branchId, tableId: tableId, note: note)
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
