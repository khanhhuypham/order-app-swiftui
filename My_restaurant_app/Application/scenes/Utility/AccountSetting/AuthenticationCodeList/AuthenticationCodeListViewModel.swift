//
//  OrderHistoryViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//


import SwiftUI

class AuthenticationCodeListViewModel: ObservableObject {

    
    @Published var list: [AuthenticationToken] = []

 
    func getAuthCodeList(){

        NetworkManager.callAPI(netWorkManger: .getCodeAuthenticationList){[weak self] (result: Result<APIResponse<[AuthenticationToken]>, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok,let data = res.data{
                        list = data.filter{$0.status == ACTIVE && TimeUtils.getRemainingSeconds(from: $0.expire_at) > 0}
                    }
                        
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    func changeStatusOfAuthenticationCode(id:Int){
        NetworkManager.callAPI(netWorkManger: .postChangeStatusOfAuthenticationCode(id:id)){[weak self] (result: Result<PlainAPIResponse, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        getAuthCodeList()
                    }
                        
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    func createAuthenticationCode(expire_at:String,code:String){
   
        NetworkManager.callAPI(netWorkManger: .postCreateAuthenticationCode(expire_at: expire_at, code: code)){[weak self] (result: Result<PlainAPIResponse, Error>) in
            guard let self = self else { return }
            
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        getAuthCodeList()
                    }
                        
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
    }
    
    
    
    
}
