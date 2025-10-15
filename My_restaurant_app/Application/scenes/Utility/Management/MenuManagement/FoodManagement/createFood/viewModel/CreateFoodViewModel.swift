//
//  FoodManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 23/10/2024.
//

import SwiftUI

class CreateFoodViewModel:ObservableObject {
    private(set) var view: CreateFoodView?

    let branchId = Constants.branch.id
    let brandId = Constants.brand.id
    @Published var food:Food = Food()
    @Published var childrenItem:[ChildrenItem] = []
    @Published var categories:[Category] = []
    @Published var units:[Unit] = []
    @Published var printers:[Printer] = []
    
    func bind(view:CreateFoodView){
        self.view = view
    }
    
}


extension CreateFoodViewModel{
    
    func getCategories(){

//        NetworkManager.callAPI(netWorkManger:.categories(brand_id:brandId,active:true)){[weak self] result in
//
//            guard let self = self else { return }
//
//            switch result {
//                case .success(let data):
//
//                    guard var res = try? JSONDecoder().decode(APIResponse<[Category]>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//                
//                 
//                    categories = res.data
//
//                    for (i,cate) in categories.enumerated() {
//                        
//                        if food.id > 0{
//                            categories[i].isSelect = food.category_id == cate.id
//                        }else{
//                            categories[0].isSelect = true
//                        }
//                    }
//                
//                case .failure(let error):
//                    print(error)
//            }
//        }
    }
    
    func getChildrenItem(){

//        NetworkManager.callAPI(netWorkManger:.childrenItem){[weak self] result in
//
//            guard let self = self else { return }
//
//            switch result {
//                case .success(let data):
//
//                    guard var res = try? JSONDecoder().decode(APIResponse<[ChildrenItem]>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//               
//                    childrenItem = res.data
//
//                case .failure(let error):
//                    print(error)
//            }
//        }
    }
    
    func getUnits(){

//        NetworkManager.callAPI(netWorkManger:.units){[weak self] result in
//
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let data):
//                
//                guard var res = try? JSONDecoder().decode(APIResponse<[Unit]>.self, from: data) else{
//                    dLog("Parse model sai")
//                    return
//                }
//                
//                
//                
//                units = res.data
//                
//                for (i,unit) in units.enumerated() {
//                    
//                    if food.id > 0{
//                        units[i].isSelect = food.unit_type == unit.name
//                    }else{
//                        units[0].isSelect = true
//                    }
//                
//                }
//
//
//                case .failure(let error):
//                    print(error)
//            }
//        }
    }
    
    
    func getPrinters(){

//        NetworkManager.callAPI(netWorkManger:.getPrinters(branch_id: branchId)){[weak self] result in
//
//            guard let self = self else { return }
//
//            switch result {
//                case .success(let data):
//
//                    guard var res = try? JSONDecoder().decode(APIResponse<[Printer]>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//                   
//                    printers = res.data
//                
//                    for (i,printer) in printers.enumerated() {
//                        if food.id > 0{
//                            printers[i].isSelect = food.printer_id == printer.id
//                        }else{
//                            printers[0].isSelect = true
//                        }
//                    }
//
//
//                case .failure(let error):
//                    print(error)
//            }
//        }
    }
    
    
    func createItem(item:Food){
//        NetworkManager.callAPI(netWorkManger:.createFood(branch_id: branchId, item: item)){[weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                case .success(let data):
//             
//                    guard var res = try? JSONDecoder().decode(APIResponse<Food>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//                
//                    view?.presentationMode.wrappedValue.dismiss()
//                
//                case .failure(let error):
//                print(error)
//            }
//        }
    }
}
