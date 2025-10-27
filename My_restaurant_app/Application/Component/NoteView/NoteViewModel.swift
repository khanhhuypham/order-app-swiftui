//
//  NoteViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/07/2025.
//

import SwiftUI

class NoteViewModel: ObservableObject {
    
    @Published var noteList:[Note] = []
    
    
    func notes() async{
        
        let result:Result<APIResponse<[Note]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .notes(branch_id: Constants.branch.id))
        
        switch result {

            case .success(let res):
                if res.status == .ok,let data = res.data{
                    noteList = data
                }
                break
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func notesByFood(foodId:Int) async{
        let result:Result<APIResponse<[Note]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .notesByFood(food_id: foodId, branch_id: Constants.branch.id))
        switch result {

            case .success(let res):
                if res.status == .ok,let data = res.data{
                    noteList = data
                    dLog(data.count)
                }
                break
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
}
