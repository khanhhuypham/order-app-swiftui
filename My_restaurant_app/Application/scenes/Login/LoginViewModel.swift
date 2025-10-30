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
                guard res.status == .ok,let data = res.data else {
                    dLog("⚠️ API status not ok")
                    return
                }

                ManageCacheObject.deleteItem(Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT)
                await getConfig(sessionStr: data)

        case .failure(let err):
            dLog("❌ Network error: \(err)")
        }
    }

    

    func getConfig(sessionStr: String) async {
        
        let result: Result<APIResponse<Config>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .config(restaurant_name: restaurant))
        
        switch result {
            case .success(let res):
                guard res.status == .ok,let data = res.data else {
                    dLog("⚠️ Config API returned non-ok status: \(res.status)")
                    return
                }

                var config = data
                config.api_key = "\(sessionStr):\(config.api_key ?? "")"
                ManageCacheObject.setConfig(config)
                await login()

            case .failure(let error):
                dLog("❌ Config API failed: \(error)")
            }
        
    }
    
    
    @MainActor
    func login() async {
        let result: Result<APIResponse<Account>, Error> = await NetworkManager.callAPIResultAsync(netWorkManger: .login(username: username, password: password))
        
        switch result {
            case .success(let res):
                guard res.status == .ok,var data = res.data else {
                    AppState.shared.userState = .notLoggedIn
                    dLog("❌ Login failed with status: \(res.status)")
                    return
                }
                
                // ✅ Save access token + password securely
                if let token = data.access_token {
                    _ = utils.keyChainUtils.savePassword(password: password)
                    if utils.keyChainUtils.saveAccessToken(accessToken: token) {
                        data.access_token = nil
                        data.password = nil
                        ManageCacheObject.saveUser(data)
                    }
                }
                
                // ✅ Save brand info
                var brand = Brand()
                brand.id = data.restaurant_brand_id
                brand.name = data.brand_name
                brand.restaurant_id = data.restaurant_id ?? 0
                ManageCacheObject.setBrand(brand)
                
                // ✅ Continue flow
                await SettingUtils.getSetting(
                    brandId: data.restaurant_brand_id,
                    branchId: data.branch_id ?? 0,
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
    


