//
//  AreaManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/10/2024.
//

import SwiftUI

class AreaManagementViewModel: ObservableObject {
    let branchId = Constants.branch.id ?? 0
    
    @Published var btnArray:[(id:Int?,title:String,isSelect:Bool)] = []
    @Published var areaList:[Area] = []
    @Published var table:[Table] = []
    @Published var APIParameter:(tab:Int,isPresent:Bool,popup:(any View)?) = (
        tab: 1,
        isPresent:false,
        popup:nil
    )
  

    func showPopup(area:Area? = nil,table:Table? = nil,confirm:(()->Void)? = nil){
        let binding = Binding(
            get: { self.APIParameter.isPresent },
            set: { self.APIParameter.isPresent = $0 }
        )
        APIParameter.isPresent = true
        if let area = area{
            APIParameter.popup = CreateAreaView(isPresent:binding,area:area,onConfirmPress: {[weak self](area) in
                guard let self = self else { return }
                self.createArea(area: area)
            })
        }else if let table = table{
            APIParameter.popup = CreateTableView(isPresent: binding,table: table,areaArray: areaList,onConfirmPress: {[weak self](table) in
                guard let self = self else { return }
                self.createTable(table: table)
            })
        }else{
            APIParameter.popup = QuicklyCreateTableView(isPresent: binding,areaArray: areaList,onConfirmPress: {[weak self](tableList,areaId) in
                guard let self = self else { return }
                self.createTableQuickly(areaId: areaId, tables: tableList)
            })
        }
    
    }
    
    func getAreaList(){
        
        NetworkManager.callAPI(netWorkManger: .areas(branch_id: branchId)){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard var res = try? JSONDecoder().decode(APIResponse<[Area]>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                    
                    if APIParameter.tab == 2{
                        var list = res.data
                        list.insert(Area(name: "Tất cả khu vực", isSelect: true), at: 0)
                        
                        btnArray = list.map{area in
                            return (id:area.id,title:area.name,isSelect:area.isSelect)
                        }
                            
                        self.getTables(areaId: nil)
                    }else{
                        self.areaList = res.data
                    }
                
                  
              
                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    
    func getTables(areaId:Int?){
        NetworkManager.callAPI(netWorkManger: .tablesForManagement(area_id: areaId)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard var res = try? JSONDecoder().decode(APIResponse<[Table]>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
                    
                    for (i,table) in res.data.enumerated(){
                        res.data[i].order = OrderOfTable(status: .open)
                    }
                
                    self.table = res.data
                    
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
    
}

extension AreaManagementViewModel {
    
    func createArea(area:Area,is_confirmed:Int? = nil){
        
        NetworkManager.callAPI(netWorkManger: .createArea(branch_id: branchId, area: area, is_confirm: is_confirmed)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard var res = try? JSONDecoder().decode(APIResponse<Area>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
              
                    if(res.status == .ok){
                     
//                        JonAlert.showSuccess(
//                            message: self.viewModel.area.value.id > 0 ? "Cập nhật khu vực thành công" : "Tạo khu vực thành công",
//                            duration: 2.0
//                        )
//        
//                        (self.completeHandler ?? {})()
//        
//                        self.actionDismiss("")
                    }else if res.status == .multipleChoices {
        
//                        self.presentConfirmPopup(
//                            content: "Khu vực hiện có bàn đang hoạt động. Bạn muốn tắt toàn bộ bàn của khu vực này",
//                            confirmClosure:{
//                                self.createArea(is_confirmed: ACTIVE)
//                            },
//                            cancelClosure: {
//                                self.actionDismiss("")
//                            }
//                        )
        
                    }else{
        
                       
                        dLog(res.message)
                    }
                    getAreaList()
//                    for (i,table) in res.data.enumerated(){
//                        res.data[i].status = .using
//                    }
//                
//                    self.table = res.data
                    
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
    func createTable(table:Table){
        
        NetworkManager.callAPI(netWorkManger:.createTable(
            branch_id: branchId,
            table_id: table.id ?? 0,
            table_name:table.name ?? "",
            area_id:table.area_id ?? 0,
            total_slot:table.slot_number ?? 0,
            active: table.active ?? true
        )){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let data):
                    
                    guard var res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
                    
                    getTables(areaId: areaList.first{$0.isSelect}?.id ?? -1)


                case .failure(let error):
                dLog(error)
            }
        }
    }
    
    
    func createTableQuickly(areaId:Int,tables:[CreateTableQuickly]){
        
        NetworkManager.callAPI(netWorkManger:.postCreateTableList(
            branch_id: branchId,
            tables: tables
        )){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let data):
                    
                    guard var res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
                    
                    getTables(areaId: areaId)

                case .failure(let error):
                dLog(error)
            }
        }
    }
    
}
