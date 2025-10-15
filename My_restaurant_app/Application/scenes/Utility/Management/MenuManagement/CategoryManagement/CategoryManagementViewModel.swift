//
//  CategoryManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI

class CategoryManagementViewModel: ObservableObject {
    let branchId = Constants.branch.id ?? 0
    let brandId = Constants.brand.id ?? 0
    
    @Published var categories:[Category] = []
    @Published var isPresent = false
    @Published var popup:(any View)? = nil
    
    
    func showPopup(category:Category){
        let binding = Binding(
           get: { self.isPresent },
           set: { self.isPresent = $0 }
        )
        isPresent = true
        popup = CreateCategory(isPresent:binding,category:category,onConfirmPress: {category in
            self.createCategory(category: category)
        })
    }
    
    
    
}


//MARK: categories
extension CategoryManagementViewModel{
    func getCategories(){
        
        NetworkManager.callAPI(netWorkManger: .categories(brand_id:brandId,status:-1)){[weak self] (result: Result<APIResponse<[Category]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        categories = res.data
                    }
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    func createCategory(category:Category){
                
        NetworkManager.callAPI(netWorkManger: .createCategory(
            id: category.id,
            name: category.name,
            code: category.code,
            description: category.description,
            categoryType: category.category_type.value,
            status:category.status
                                                    
        )){[weak self] (result: Result<PlainAPIResponse, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let data):
                    getCategories()
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
   
    
}
