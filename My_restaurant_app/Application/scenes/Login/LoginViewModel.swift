//
//  LoginViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//



import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Injected(\.utils) private var utils
    @Published var ipAddress: String = ""
    
    @Published var restaurant: String = ""{
        didSet{
            restaurantValid = restaurant.count >= 2 && restaurant.count <= 50
        }
    }
    @Published var username: String = ""{
        didSet{
            usernameValid = username.count >= 8 && username.count <= 10
        }
    }
    @Published var password: String = ""{
        didSet{
            passwordValid = password.count >= 4 && password.count <= 20
        }
    }
    @Published var code: String = ""
    
    @Published var valid: Bool = false
    
    private var restaurantValid: Bool = false { didSet { updateValid() } }
    private var usernameValid: Bool = false { didSet { updateValid() } }
    private var passwordValid: Bool = false { didSet { updateValid() } }


    private func updateValid() {
        valid = restaurantValid && usernameValid && passwordValid
    }
    

}

extension LoginViewModel{

    @MainActor
    func getSession() async {
        let result: Result<APIResponse<String>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .sessions)

        switch result {
            case .success(let res):
                guard res.status == .ok else {
                    dLog("⚠️ API status not ok")
                    return
                }

                ManageCacheObject.deleteItem(Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT)
                await getConfig(sessionStr: res.data)

        case .failure(let err):
            dLog("❌ Network error: \(err)")
        }
    }

    

    func getConfig(sessionStr: String) async {
        
        let result: Result<APIResponse<Config>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .config(restaurant_name: restaurant))
        
        switch result {
            case .success(let res):
                guard res.status == .ok else {
                    dLog("⚠️ Config API returned non-ok status: \(res.status)")
                    return
                }

                var config = res.data
                config.api_key = "\(sessionStr):\(config.api_key ?? "")"
                ManageCacheObject.setConfig(config)
                await login()

            case .failure(let error):
                dLog("❌ Config API failed: \(error)")
            }
        
    }
    
    

    func login() async {
        let result: Result<APIResponse<Account>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .login(username: username, password: password))
        
        switch result {
            case .success(var res):
                guard res.status == .ok else {
                    AppState.shared.userState = .notLoggedIn
                    dLog("❌ Login failed with status: \(res.status)")
                    return
                }
                
                // ✅ Save access token + password securely
                if let token = res.data.access_token {
                    _ = utils.keyChainUtils.savePassword(password: password)
                    if utils.keyChainUtils.saveAccessToken(accessToken: token) {
                        res.data.access_token = nil
                        res.data.password = nil
                        ManageCacheObject.saveUser(res.data)
                    }
                }
                
                // ✅ Save brand info
                var brand = Brand()
                brand.id = res.data.restaurant_brand_id
                brand.name = res.data.brand_name
                brand.restaurant_id = res.data.restaurant_id ?? 0
                ManageCacheObject.setBrand(brand)
                
                // ✅ Continue flow
                await SettingUtils.getSetting(
                    brandId: res.data.restaurant_brand_id,
                    branchId: res.data.branch_id ?? 0,
                    completion: {
                        AppState.shared.userState = .loggedIn
                    },
                    incompletion: {
                        dLog("⚠️ Get setting failed")
                        AppState.shared.userState = .notLoggedIn
                    }
                )
                
            case .failure(let error):
                AppState.shared.userState = .notLoggedIn
                dLog("❌ Login API error: \(error)")
        }
    }


}
    


//extension LoginViewModel{
//    
//    func getSession(){
//       
//        NetworkManager.callAPI(netWorkManger: .sessions){(result: Result<APIResponse<String>, Error>) in
//      
//            switch result {
//
//                case .success(let res):
//                    if res.status == .ok{
//                        self.getConfig(sessionStr: res.data)
//                        ManageCacheObject.deleteItem(Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT)
//                    }
//                case .failure(let error):
//                   dLog("Error: \(error)")
//            }
//        }
//        
//    }
//    
//    func getConfig(sessionStr:String) {
//
//        
//        NetworkManager.callAPI(netWorkManger: .config(restaurant_name: restaurant)){(result: Result<APIResponse<Config>, Error>) in
//          
//            
//            switch result {
//
//                case .success(let res):
//                
//                    if res.status == .ok{
//                        var config = res.data
//                        config.api_key = String(format: "%@:%@", sessionStr, config.api_key ?? "")
//                        ManageCacheObject.setConfig(config)
//                        // call api login here...
//                        self.login()
//                    }
//                
//                case .failure(let error):
//                   dLog("Error: \(error)")
//            }
//        }
//    }
//    
//    
//    func login(){
//        
//        
//        NetworkManager.callAPI(netWorkManger: .login(username: username, password: password)){[weak self](result: Result<APIResponse<Account>, Error>) in
//            guard let self = self else { return }
//            
//            switch result {
//
//                case .success(var res):
//                
//                    if res.status == .ok{
//                    
//                        if let token = res.data.access_token{
//                            _ = self.utils.keyChainUtils.savePassword(password: self.password)
//                            if self.utils.keyChainUtils.saveAccessToken(accessToken: token) {
//                                res.data.access_token = nil
//                                res.data.password = nil
//                                ManageCacheObject.saveUser(res.data)
//                            }
//                            
//                        }
//                        
//                        var brand = Brand.init()
//                        brand.id = res.data.restaurant_brand_id
//                        brand.name = res.data.brand_name
//                        brand.restaurant_id = res.data.restaurant_id ?? 0
//                        ManageCacheObject.setBrand(brand)
//                        
//                        
//                        SettingUtils.getSetting(
//                            brandId: res.data.restaurant_brand_id,
//                            branchId: res.data.branch_id ?? 0,
//                            completion: {
//                                dLog("Get setting success")
//                                AppState.shared.userState = .loggedIn
//                            },
//                            incompletion:{
//                                dLog("Get setting fail")
//                                AppState.shared.userState = .notLoggedIn
//                            }
//                        )
//                    }
//                
//                
//                
//                case .failure(let error):
//                   dLog("Error: \(error)")
//            }
//        }
//    }
//}
