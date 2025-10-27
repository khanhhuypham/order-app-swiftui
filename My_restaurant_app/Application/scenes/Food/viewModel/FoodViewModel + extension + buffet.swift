//
//  FoodViewModel + extension.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 28/09/2024.
//

import UIKit

extension FoodViewModel {
    func getBuffetTickets() async{
        
        let result:Result<BuffetResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getBuffetTickets(
            brand_id: Constants.brand.id ?? 0,
            status: ACTIVE,
            key_search:APIParameter.key_word,
            limit: APIParameter.limit,
            page: APIParameter.page
        ))
        
        switch result {

            case .success(var data):
                for (i,buffet) in data.list.enumerated() {
                    data.list[i].updateTickets()
                }
                
                if let selectedItem = self.selectedBuffet,
                   let p = data.list.firstIndex(where: {$0.id == selectedItem.id}){
                    data.list[p] = selectedItem
                }
                
                self.buffets = data.list
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func getDetailOfBuffetTicket(buffet:Buffet) async {
        
        let result:Result<FoodResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getDetailOfBuffetTicket(
            branch_id: Constants.branch.id ?? 0,
            category_id: APIParameter.category_id,
            buffet_ticket_id: buffet.buffet_ticket_id ?? 0,
            key_search: APIParameter.key_word,
            limit: APIParameter.limit,
            page: APIParameter.page
        ))

        switch result {

            case .success(var data):
            
              self.APIParameter.total_record = data.total_record
              
              
              for (i,element) in data.list.enumerated(){
                  if let selectedItem = self.selectedFoods.first(where: {$0.id == element.id}){
                      data.list[i] = selectedItem
                  }
              }
              self.foods.append(contentsOf: data.list)
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
   
}
