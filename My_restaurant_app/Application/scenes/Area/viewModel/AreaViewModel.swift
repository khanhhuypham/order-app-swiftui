//
//  AreaViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI


class AreaViewModel: ObservableObject {
    @Published var shouldNavigateBack: Bool = false // 👈 Add this
    @Published var table:[Table] = []
    @Published var area:[Area] = []
    
    
    @Published var presentDialog:Bool = false

    
    var order: Order? = nil
    var orderAction: OrderAction? = nil
    var selectedTable: Table? = nil

}

extension AreaViewModel{

    func getAreas() async{
        
        let result:Result<APIResponse<[Area]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .areas(branch_id: Constants.branch.id, status: ACTIVE))
        
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    var list = data
                    list.insert(Area(id: -1, name: "Tất cả khu vực", isSelect: true), at: 0)
                    self.area = list
                    
                    await getTables(areaId: -1)
                }
            
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    func getTables(areaId:Int) async{
        
        
            if let action = orderAction{
           
                switch action {
                    
                    case .moveTable:
                        await callAPI(areaId: areaId,status: [.closed],exclude_table_id: order?.table_id ?? 0)
                    
                    case .mergeTable:
                        await callAPI(areaId: areaId,status: [.closed,.using,.booking],exclude_table_id: order?.table_id ?? 0)
                    
                    case .splitFood:
                        await callAPI(areaId: areaId,status: [.closed,.using,.booking],exclude_table_id: order?.table_id ?? 0)
                    
                    default:
                        break
                }
                
            }else{
                await callAPI(areaId: areaId)
            }
        
        
        func callAPI(areaId:Int,status:[TableStatus] = [],exclude_table_id:Int = 0)async{
            
            var tableStatus = ""
            
            for (index,s) in status.enumerated(){
                if index < status.count - 1 {
                    tableStatus.append(String(format: "%d,", s.rawValue))
                }else{
                    tableStatus.append(s.rawValue.description)
                }
                
            }
            
            let result:Result<APIResponse<[Table]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger:.tables(branchId: Constants.branch.id, area_id: areaId, status:tableStatus, exclude_table_id: exclude_table_id))
            
            switch result {

                case .success(let res):
                
                    if res.status == .ok,var data = res.data{
                        if orderAction == nil{
                            
                            self.table = data
                            
                        }else{
                            
                            self.table = data.filter({$0.status != .booking && $0.status != .mergered && $0.order_status != 1 && $0.order_status != 4})
                            
                        }
                        
                    }
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
            
        }
        
        
    }
    
    

    @MainActor
    func moveTable(from:Int,to:Int) async{
        
        let result: Result<APIResponse<Account>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .moveTable(branch_id:Constants.branch.id,from: from, to: to))
        switch result {
            case .success(let res):
                    
                if res.status == .ok{
                    presentDialog = false
                    shouldNavigateBack = true
                }else{
                    dLog(res.message)
                }
            
            case .failure(let error):
                dLog(error)
        }

    }
    
    @MainActor
    func mergeTable(destination_table_id:Int,target_table_ids:[Int])async{
        
        let result: Result<PlainAPIResponse,Error> = await NetworkManager.callAPIResultAsync(netWorkManger:.mergeTable(branch_id: Constants.branch.id, destination_table_id: destination_table_id, target_table_ids: target_table_ids))
        
        switch result {
            case .success(let res):
                    
                if res.status == .ok{
                    presentDialog = false
                    shouldNavigateBack = true
                }else{
                    dLog(res.message)
                }
            
                
            case .failure(let error):
                dLog(error)
        }
        
        

    }
    
  
    
    
}
