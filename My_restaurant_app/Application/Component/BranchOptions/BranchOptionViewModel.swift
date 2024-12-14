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
    
    
    func getBrands(){
        
        NetworkManager.callAPI(netWorkManger: .brands(key_search: "", status: ACTIVE)){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[Brand]>.self, from: data) else{
                        return
                    }
                                    
                    self.brands = res.data.filter{$0.is_office == DEACTIVE}
              
                
                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    func getBranches(brand:Brand){
        
        NetworkManager.callAPI(netWorkManger: .branches(brand_id: brand.id ?? 0, status: ACTIVE)){[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[Branch]>.self, from: data) else{
                        return
                    }
                        
                
                    self.branches = res.data.filter{$0.is_office == DEACTIVE}
                    self.type = 2
                
                  case .failure(let error):
                      print(error)
            }
        }
    }
    
    
}
