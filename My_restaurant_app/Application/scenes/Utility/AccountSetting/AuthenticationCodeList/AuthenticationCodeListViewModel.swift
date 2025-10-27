//
//  OrderHistoryViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//


import SwiftUI

class AuthenticationCodeListViewModel: ObservableObject {

    
    @Published var list: [AuthenticationToken] = []

 
    func getAuthCodeList() async{

        let result:Result<APIResponse<[AuthenticationToken]>, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getCodeAuthenticationList)
        
        switch result {

            case .success(let res):
                if res.status == .ok,let data = res.data{
                    list = data.filter{$0.status == ACTIVE && TimeUtils.getRemainingSeconds(from: $0.expire_at) > 0}
                }
                    
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    func changeStatusOfAuthenticationCode(id:Int) async {
        let result:Result<PlainAPIResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getCodeAuthenticationList)
        
        switch result {

            case .success(let res):
                if res.status == .ok{
                    await getAuthCodeList()
                }
                    
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    func createAuthenticationCode(expire_at:String,code:String) async{
        let result:Result<PlainAPIResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .postCreateAuthenticationCode(expire_at: expire_at, code: code))
        switch result {
            case .success(let res):
                if res.status == .ok{
                    await getAuthCodeList()
                }
                    
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    
    
    
}
