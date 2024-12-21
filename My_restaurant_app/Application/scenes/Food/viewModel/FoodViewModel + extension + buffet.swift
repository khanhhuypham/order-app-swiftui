//
//  FoodViewModel + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 28/09/2024.
//

import UIKit

extension FoodViewModel {
    func getBuffetTickets(){
        
        NetworkManager.callAPI(netWorkManger: .getBuffetTickets(
            brand_id: Constants.brand.id ?? 0,
            status: ACTIVE,
            key_search:APIParameter.key_word,
            limit: APIParameter.limit,
            page: APIParameter.page)
        ){[weak self] result in
            guard let self = self else { return }
            switch result {
                  case .success(let data):
                        
                    guard var res = try? JSONDecoder().decode(APIResponse<BuffetResponse>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
               
                    
                    for (i,buffet) in res.data.list.enumerated() {
                        res.data.list[i].updateTickets()
                    }
                    
                    if let selectedItem = self.selectedBuffet,
                       let p = res.data.list.firstIndex(where: {$0.id == selectedItem.id}){
                        res.data.list[p] = selectedItem
                    }
                    
                    self.buffets = res.data.list
                    
            
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
    func getDetailOfBuffetTicket(buffet:Buffet) {
        
        NetworkManager.callAPI(netWorkManger:.getDetailOfBuffetTicket(
            branch_id: Constants.branch.id ?? 0,
            category_id: APIParameter.category_id ?? 0,
            buffet_ticket_id: buffet.buffet_ticket_id ?? 0,
            key_search: APIParameter.key_word,
            limit: APIParameter.limit,
            page: APIParameter.page
        )){[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                
                guard var res = try? JSONDecoder().decode(APIResponse<FoodResponse>.self, from: data) else{
                    dLog("parse model sai rồi")
                    return
                }
              
            
              
                self.APIParameter.total_record = res.data.total_record
                
                
                for (i,element) in res.data.list.enumerated(){
                    if let selectedItem = self.selectedFoods.first(where: {$0.id == element.id}){
                        res.data.list[i] = selectedItem
                    }
                }
                self.foods.append(contentsOf: res.data.list)
                
                
            case .failure(let error):
                dLog(error)
            }
        }
    }
    
   
}
