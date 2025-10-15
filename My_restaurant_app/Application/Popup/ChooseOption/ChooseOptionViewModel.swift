//
//  ChooseOptionViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 08/07/2025.
//

import SwiftUI

class ChooseOptionViewModel: ObservableObject {

    @Published var item:Food = Food()
    
    @Published var noteList:[Note] = []
    
   
    func firstSetup(){
        
        item.quantity = item.quantity == 0 ? 1 : item.quantity

        
        for (i,_) in item.food_options.enumerated(){
            var option = item.food_options[i]
            
            if option.min_items_allowed > option.addition_foods.filter{$0.isSelect}.count{
                
                for (j,_) in option.addition_foods.filter{$0.isSelect == false}.enumerated(){
               
                    
                    if option.addition_foods.filter{$0.isSelect}.count == option.min_items_allowed{
                        continue
                    }else if option.addition_foods.filter{$0.isSelect}.count > option.max_items_allowed{
                        option.addition_foods[j].isSelect = false
                        option.addition_foods[j].quantity = 0
                    }else{
                        option.addition_foods[j].isSelect = true
                        option.addition_foods[j].quantity = 1
                    }
        
                }
                
            }
            
            item.food_options[i] = option
        }
        
        PermissionUtils.GPBH_1 ? notes() : notesByFood()
   
    }
    
    private func notes() {
        NetworkManager.callAPI(netWorkManger: .notes(branch_id: Constants.branch.id ?? 0)){[weak self] (result: Result<APIResponse<[Note]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        noteList = res.data
                    }
                    break
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    private func notesByFood() {
        NetworkManager.callAPI(netWorkManger: .notesByFood(food_id: item.id, branch_id: Constants.branch.id ?? 0)){[weak self] (result: Result<APIResponse<[Note]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                
                    if res.status == .ok{
                        noteList = res.data
                    }
                    break
                    
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    
}
