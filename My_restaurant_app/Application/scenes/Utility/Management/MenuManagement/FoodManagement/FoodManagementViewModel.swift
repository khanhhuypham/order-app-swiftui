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
    @Published var childrenItem:[ChildrenItem] = []

    @Published var tab = 1
    @Published var tabArray:[(id:Int,title:String,isSelect:Bool)] = [
        (id:1,title:"MÓN THƯỜNG",isSelect:true),
        (id:2,title:"BÁN KÈM / TOPPING",isSelect:false),
    ]
    
    
    @Published var APIParameter : (
        category_id:Int,
        search_key:String,
        limit:Int,
        page:Int,
        total_record:Int
    ) =  (
        category_id:-1,
        search_key:"",
        limit:20,
        page:1,
        total_record:0
    )
    
    //MARK: - PAGINATION
    func loadMoreContent(){
        if self.foods.endIndex < APIParameter.total_record {
            APIParameter.page += 1
            getFood(isAddition: DEACTIVE)
        }
    }
    
    
    //MARK: - PAGINATION
    func reloadContent(){
        foods.removeAll()
        APIParameter.page = 1
        getFood(isAddition: DEACTIVE)
    }
    
    
}

//MARK: categories
extension FoodManagementViewModel{
    func getFood(isAddition:Int){
        NetworkManager.callAPI(netWorkManger:.foodsManagement(
            category_id: APIParameter.category_id,
            search_key: APIParameter.search_key,
            limit: APIParameter.limit,
            page: APIParameter.page
        )){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let data):

                    guard var res = try? JSONDecoder().decode(APIResponse<FoodResponse>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
            
                
                    self.APIParameter.total_record = res.data.total_record
                    
                    self.foods.append(contentsOf: res.data.list)

                case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getChildrenItems(){
        NetworkManager.callAPI(netWorkManger:.childrenItem){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let data):
             
                    guard var res = try? JSONDecoder().decode(APIResponse<[ChildrenItem]>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                    childrenItem = res.data
                    
                
                case .failure(let error):
                print(error)
            }
        }
    }
    
    
  
    
    

}
