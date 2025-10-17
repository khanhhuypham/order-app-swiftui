//
//  NoteViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 11/07/2025.
//

import SwiftUI

class NoteViewModel: ObservableObject {
    
    @Published var noteList:[Note] = []
    
    
    func notes() {
        NetworkManager.callAPI(netWorkManger: .notes(branch_id: Constants.branch.id)){[weak self] (result: Result<APIResponse<[Note]>, Error>) in
            guard let self = self else { return }
            
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
    }
    
    func notesByFood(foodId:Int) {
        NetworkManager.callAPI(netWorkManger: .notesByFood(food_id: foodId, branch_id: Constants.branch.id ?? 0)){[weak self] (result: Result<APIResponse<[Note]>, Error>) in
            guard let self = self else { return }
            
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
}
