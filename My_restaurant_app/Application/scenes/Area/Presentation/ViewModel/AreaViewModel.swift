import Foundation

import SwiftUI

@MainActor
class AreaViewModel: ObservableObject {
    private let useCases: AreaUseCases
    
    @Published var shouldNavigateBack = false
    @Published var table: [Table] = []
    @Published var area: [Area] = []
    @Published var presentDialog = false
    
    var order: Order? = nil
    var orderAction: OrderAction? = nil
    var selectedTable: Table? = nil
    
    init(useCases: AreaUseCases = AreaUseCases(repository: AreaRepositoryImpl())) {
        self.useCases = useCases
    }
    
    func getAreas() async {
        let result = await useCases.getAreas(branchId: Constants.branch.id, status: ACTIVE)
        
        switch result {
            case .success(var data):
                data.insert(Area(id: -1, name: "Tất cả khu vực", isSelect: true), at: 0)
                area = data
                await getTables(areaId: -1)
                
            case .failure(let err):
                dLog(err.localizedDescription)
      
        }
    }
    
    func getTables(areaId: Int) async {
        let statusArray: [TableStatus]
        let exclude = order?.table_id ?? 0
        
        switch orderAction {
            case .moveTable:
                statusArray = [.closed]
            
            case .mergeTable, .splitFood:
                statusArray = [.closed, .using, .booking]
            
            default:
                statusArray = []
        }
        
        let tableStatus = statusArray.map { String($0.rawValue) }.joined(separator: ",")
        let result = await useCases.getTables(branchId: Constants.branch.id, areaId: areaId, status: tableStatus, exclude_table_id: exclude)
        
        switch result {
            case .success(let data):
            
                if orderAction == nil {
                     self.table = data
                 } else {
                     self.table = data.filter { $0.status != .booking && $0.status != .mergered && $0.order_status != 1 && $0.order_status != 4 }
                 }
            
            case .failure(let err):
                dLog(err)
        }
    }
    
    func moveTable(from: Int, to: Int) async {
        
        let result = await useCases.moveTable(branchId: Constants.branch.id, from: from, to: to)
        
        switch result {
            case .success:
                presentDialog = false
                shouldNavigateBack = true
            
            case .failure(let error):
                dLog(error.localizedDescription)
        }
        
    }
    
    func mergeTable(destinationTableId: Int, targetTableIds: [Int]) async {
        let result = await useCases.mergeTable(branchId: Constants.branch.id, destination_table_id: destinationTableId, target_table_ids: targetTableIds)
        
        switch result {
            case .success:
                presentDialog = false
                shouldNavigateBack = true
                break
            
            case .failure(let error):
                dLog(error.localizedDescription)
        }
    }
}
