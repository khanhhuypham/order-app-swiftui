//
//  AreaRepository.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/10/25.
//


import Foundation


final class AreaUseCases {
    
    let repository: AreaRepository
    
    init(repository: AreaRepository) {
        self.repository = repository
    }

    
    func getAreas(branchId: Int, status: Int) async -> Result<[Area], Error> {
        let result = await repository.getAreas(branchId: branchId, status: status)
        
        switch result {
            case .success(let res):
                if res.status == .ok{
                    return .success(res.data ?? [])
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
            
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func getTables(branchId: Int, areaId: Int, status: String, exclude_table_id: Int) async -> Result<[Table], Error> {
        let result = await repository.getTables(branchId: branchId, areaId: areaId, status: status, exclude_table_id: exclude_table_id)
        
        switch result {
            case .success(let res):
                if res.status == .ok{
                    return .success(res.data ?? [])
                }else{
                    return .failure(NSError(domain: res.message, code:res.status.rawValue))
                }
            
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func moveTable(branchId: Int, from: Int, to: Int) async -> Result<Void, Error> {
        let result = await repository.moveTable(branchId: branchId, from: from, to: to)
        
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
    
    func mergeTable(branchId: Int, destination_table_id: Int, target_table_ids: [Int]) async -> Result<Void, Error> {
        let result = await repository.mergeTable(branchId: branchId, destination_table_id: destination_table_id, target_table_ids: target_table_ids)
        
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
