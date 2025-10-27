//
//  BranchOptionViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 04/10/2024.
//

import UIKit

class BranchOptionViewModel: ObservableObject {
    @Published var type: Int = 1
    @Published var searchText = ""
    @Published var brands: [Brand] = []
    @Published var filteredBrands: [Brand] = []
    @Published var branches: [Branch] = []
    
    
    func getBrands() async{
        let result:Result<APIResponse<[Brand]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .brands(key_search: "", status: ACTIVE))
        
        switch result {
            case .success(let res):
                if res.status == .ok,let data = res.data{
                    self.brands = data.filter{$0.is_office == DEACTIVE}
                }
                   

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func getBranches(brand:Brand) async{
        let result:Result<APIResponse<[Branch]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .branches(brand_id: brand.id, status: ACTIVE))
        
        switch result {
            case .success(let res):
                if res.status == .ok,let data = res.data{
                    self.branches = data.filter{$0.is_office == DEACTIVE}
                    self.type = 2
                }
          

            case .failure(let error):
               dLog("Error: \(error)")
        }
       
    }
    
    
}
