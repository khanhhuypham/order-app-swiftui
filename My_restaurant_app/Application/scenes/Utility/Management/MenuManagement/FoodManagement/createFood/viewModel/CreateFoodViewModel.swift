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
    @Published var food:CreateFood = CreateFood()
    @Published var childrenItem:[Food] = []
    @Published var categories:[Category] = []
    @Published var units:[Unit] = []
    @Published var printers:[Printer] = []
    @Published var vats:[Vat] = []
    
    
    
    func bind(view:CreateFoodView){
        self.view = view
    }
    
}


extension CreateFoodViewModel{
    @MainActor
    func getCategories() async{
        
        let result: Result<APIResponse<[Category]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger:  .categories(
                brand_id: Constants.brand.id,
                status: ACTIVE
        ))
        
        switch result {
            case .success(let res):
                if res.status == .ok, let data = res.data {
                    categories = data
        
                    for (i,cate) in categories.enumerated() {

                       if food.id > 0{
                           categories[i].isSelect = food.category_id == cate.id
                       }else{
                           categories[0].isSelect = true
                       }
                    }
                }

        case .failure(let error):
            print(error)
        }
    }
    
    func getChildrenItem() async{
        
        let result: Result<APIResponse<[Food]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .foodsManagement(branch_id:Constants.branch.id, is_addition: ACTIVE, status:ACTIVE)
        )
        
        switch result {
            case .success(let res):
                if res.status == .ok,let data = res.data  {
                    childrenItem = data
                }

            case .failure(let error):
                print(error)
        }
    }

    @MainActor
    func getUnits() async{
        
        let result: Result<APIResponse<[Unit]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .units
        )
        
        switch result {
            case .success(let res):
                if res.status == .ok,let data = res.data  {
                    
                    units = data
                    
                    for (i,unit) in units.enumerated() {
                        
                        if food.id > 0{
                            units[i].isSelect = food.unit_type == unit.name
                        }else{
                            units[0].isSelect = true
                        }
                    
                    }
                }else{
                    
                }
        
            case .failure(let error):
                dLog("❌ Orders API failed: \(error)")
        }
    }
    
    @MainActor
    func getPrinters() async{
        let result: Result<APIResponse<[Printer]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .getPrinters(branch_id: Constants.branch.id)
        )

        switch result {
            case .success(let res):
                if res.status == .ok, let data = res.data {
                    printers = data

                    for (i, printer) in printers.enumerated() {
                        if food.id > 0 {
                             printers[i].isSelect = food.printer_id == printer.id
                        } else {
                            printers[0].isSelect = true
                        }
                    }
                }

        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    func getVats() async{
        let result: Result<APIResponse<[Vat]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .vats
        )

        switch result {
            case .success(let res):
                if res.status == .ok, var data = res.data {
                    guard !data.isEmpty else { return }
                    
                    if(food.vat_id > 0) {
                        if let position = data.firstIndex(where: {$0.id == food.vat_id}){
                            food.vat_id = data[position].id
                            data[position].isSelect = true
                            
                        }
                    }else{
                        food.vat_id = data[0].id
                        data[0].isSelect = true
                    }
                    
                    self.vats = data
                }

        case .failure(let error):
            print(error)
        }
    }

    
    
    func createFood(item:CreateFood)async{
        
        let result: Result<APIResponse<Food>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .createFood(branch_id: branchId, food: item)
        )
        
        switch result {
           case .success(let data):

               view?.presentationMode.wrappedValue.dismiss()

           case .failure(let error):
            print(error)
        }
        

    }
    
    @MainActor
    func updateFood(food:CreateFood)async{
        
        let result: Result<APIResponse<Food>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .updateFood(branch_id: branchId, food: food)
        )
        
        switch result {
            case .success(let res):
                
               view?.presentationMode.wrappedValue.dismiss()

            case .failure(let error):
            print(error)
        }
        

    }
}
