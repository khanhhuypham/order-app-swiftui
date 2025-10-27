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
            Task{
                await self.createCategory(category: category)
            }
        })
    }
    
    
    
}


//MARK: categories
extension CategoryManagementViewModel{
    func getCategories() async{
        
        let result:Result<APIResponse<[Category]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .categories(brand_id:brandId,status:-1))
        
        switch result {

            case .success(let res):
                if res.status == .ok,let data = res.data{
                    categories = data
                }
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func createCategory(category:Category)async{
        let result:Result<APIResponse<[Category]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger:  .createCategory(
            id: category.id,
            name: category.name,
            code: category.code,
            description: category.description,
            categoryType: category.category_type.value,
            status:category.status
                                                    
        ))
        
        switch result {

            case .success(let data):
                await getCategories()
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
   
    
}
