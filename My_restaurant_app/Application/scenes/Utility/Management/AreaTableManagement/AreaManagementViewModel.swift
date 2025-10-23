//
//  AreaManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

class AreaManagementViewModel: ObservableObject {
    let branchId = Constants.branch.id ?? 0
    @Published var areaList:[Area] = []
    @Published var table:[Table] = []
    @Published var tab = 1
    
    @Published var isPresent = false
    @Published var popup:(any View)? = nil
    
    @Published var btnArray:[(id:Int,title:String,isSelect:Bool)] = []

    func showPopup(area:Area? = nil,table:Table? = nil,confirm:(()->Void)? = nil){
        let binding = Binding(
           get: { self.isPresent },
           set: { self.isPresent = $0 }
        )
        isPresent = true
        if let area = area{
            popup = CreateAreaView(isPresent:binding,area:area,onConfirmPress: {[weak self](area) in
                guard let self = self else { return }
                self.createArea(area: area)
            })
        }else if let table = table{
            popup = CreateTableView(isPresent: binding,table: table,areaArray: areaList,onConfirmPress: {[weak self](table) in
                guard let self = self else { return }
                self.createTable(table: table)
            })
        }else{
            popup = QuicklyCreateTableView(isPresent: binding,areaArray: areaList,onConfirmPress: {[weak self](tableList,areaId) in
                guard let self = self else { return }
                self.createTableQuickly(areaId: areaId, tables: tableList)
            })
        }
    
    }
    
    func getAreaList(){
        

        
        NetworkManager.callAPI(netWorkManger: .areas(branch_id: branchId, status: ALL)){[weak self] (result: Result<APIResponse<[Area]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    guard res.status == .ok,var data = res.data else{
                        return
                    }
                
                    if tab == 2{
                
                        data.insert(Area(id: -1, name: "Tất cả khu vực", isSelect: true), at: 0)
                        btnArray = data.map{area in
                            return (id:area.id,title:area.name,isSelect:area.isSelect)
                        }

                        self.getTables(areaId: -1)
                    }else{
                        self.areaList = data
                    }
                        
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    func getTables(areaId:Int){

        
        NetworkManager.callAPI(netWorkManger: .tablesManager(area_id: areaId, branch_id: branchId, status: -1, is_deleted: 0)){[weak self] (result: Result<APIResponse<[Table]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(var res):
                    guard res.status == .ok,var data = res.data else{
                        return
                    }
                
                    for (i,table) in data.enumerated(){
                        data[i].status = table.is_active == ACTIVE ? .using : .closed
                    }
                
                    self.table = data
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    
    
}

extension AreaManagementViewModel {
    
    func createArea(area:Area,is_confirmed:Int? = nil){
        

        NetworkManager.callAPI(netWorkManger:.createArea(branch_id: branchId, area: area, is_confirm: is_confirmed)){[weak self] (result: Result<Table, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let data):
                    break
//                      self.table = data
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    func createTable(table:Table){
    
        NetworkManager.callAPI(netWorkManger: .createTable(
            branch_id: branchId,
            table_id: table.id ?? 0,
            table_name:table.name ?? "",
            area_id:table.area_id ?? 0,
            total_slot:table.slot_number ?? 0,
            status:table.is_active ?? 0
        )){[weak self] (result: Result<PlainAPIResponse, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        getTables(areaId: areaList.first{$0.isSelect}?.id ?? -1)
                    }
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    func createTableQuickly(areaId:Int,tables:[CreateTableQuickly]){

        
        
        NetworkManager.callAPI(netWorkManger: .postCreateTableList(
            branch_id: branchId,
            area_id: areaId,
            tables: tables
        )){[weak self] (result: Result<PlainAPIResponse, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        getTables(areaId: areaId)
                    }
                    
                  
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
        
    }
    
}
