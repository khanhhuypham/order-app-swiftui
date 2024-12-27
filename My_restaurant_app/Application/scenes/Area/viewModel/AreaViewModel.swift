//
//  AreaViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI


class AreaViewModel: ObservableObject {
    
    @Published var table:[Table] = []
    
    @Published var area:[Area] = []
    
   
    
   
}
extension AreaViewModel{

    func getAreas(){
        
        NetworkManager.callAPI(netWorkManger: .areas(branch_id: Constants.branch.id ?? 0, active:true)){[weak self] result in
            guard let self = self else { return }
            switch result {
                  case .success(let data):
                    
        
                    guard let res = try? JSONDecoder().decode(APIResponse<[Area]>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
      
                    
                    DispatchQueue.main.async {
                        var list = res.data
                        list.insert(Area(name: "Tất cả khu vực", isSelect: true), at: 0)
                        self.area = list
                        self.getTables()
                    }
                
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
    
    func getTables(areaId:Int? = nil){
        
        NetworkManager.callAPI(netWorkManger: .tables(branchId: Constants.branch.id ?? 0, area_id: areaId,active: true)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[Table]>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
       
                    DispatchQueue.main.async {
                        self.table = res.data
                    }
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
}
