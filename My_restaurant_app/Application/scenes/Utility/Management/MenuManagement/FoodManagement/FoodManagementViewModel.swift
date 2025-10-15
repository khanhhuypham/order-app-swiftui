//
//  FoodManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 23/10/2024.
//

import SwiftUI


class FoodManagementViewModel: ObservableObject {
    let branchId = Constants.branch.id ?? 0
    let brandId = Constants.brand.id ?? 0
    
    @Published var foods:[Food] = []

    @Published var tab = 1
    @Published var tabArray:[(id:Int,title:String,isSelect:Bool)] = [
        (id:1,title:"MÓN THƯỜNG",isSelect:true),
        (id:2,title:"BÁN KÈM / TOPPING",isSelect:false),
    ]
    
    

    
    
    
}

//MARK: categories
extension FoodManagementViewModel{
    func getFood(isAddition:Int){
        
        NetworkManager.callAPI(netWorkManger: .foodsManagement(branch_id:branchId, is_addition: isAddition,status: ALL)){[weak self] (result: Result<APIResponse<[Food]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        foods = res.data
                    }
                 
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
//    func createCategory(category:Category){
//        
//        NetworkManager.callAPI(netWorkManger:.createCategory(
//            id: category.id,
//            name: category.name,
//            code: category.code,
//            description: category.description,
//            categoryType: category.category_type.value,
//            status:category.status
//                                                    
//        )){[weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                case .success(let data):
//
//                    guard var res = try? JSONDecoder().decode(PlainAPIResponse.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//                    
//                    getCategories()
//
//                case .failure(let error):
//                
//                    print(error)
//            }
//        }
//    }
    
    

}
