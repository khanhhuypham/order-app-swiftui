//
//  AreaViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI


class AreaViewModel: ObservableObject {
    private(set)var view: AreaView?

    @Published var table:[Table] = []
    @Published var area:[(id:Int?,title:String,isSelect:Bool)] = []

    @Published var orderAction:OrderAction? = nil
    @Published var presentDialog:Bool = false
    @Published var presentSheet:Bool = false
    @Published var selected:Table? = nil
    @Published var to:Table? = nil
    
    
    func bind(view: AreaView){
        self.view = view
    }
    
  
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

                        
                        self.area = res.data.enumerated().map{ i,area in
                            return i == 0 
                            ? (id:nil,title:"Tất cả khu vực",isSelect:true)
                            : (id:area.id,title:area.name.description,isSelect:false)
                        }
                        
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
                    

                    if let action = self.orderAction{
                        
                        switch action {
                      
                            case .moveTable:
                                self.table = res.data.filter{$0.order == nil}
                            
                                if let selectedId = view?.selectedId, let firstItem = res.data.first{$0.id == selectedId}{
                                    self.selected = firstItem
                                }
                            
                            case .mergeTable:
                                if let selectedId = view?.selectedId{
                                    self.table = res.data.filter{$0.id != selectedId}
                                }
                            
                            case .splitFood:
                                if let selectedId = view?.selectedId,let firstItem = res.data.first{$0.id == selectedId}{
                                    self.table = res.data
                                    self.selected = firstItem
                                }
                           
                               
                            default:
                                break
                            
                        }
                        
                        
                     
                        
                    }else{
                        self.table = res.data
                    }
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
 
    func moveTable(from:Int,to:Int){
        
        NetworkManager.callAPI(netWorkManger: .moveTable(from: from, to: to)){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<String>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
                    
                 
                
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
    func mergeTable(){
        

    }
    
}
