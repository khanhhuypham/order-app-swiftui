//
//  LoginViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//



import SwiftUI
import AlertToast
class LoginViewModel: ObservableObject {
    @Injected(\.utils) private var utils
    
    @Published var restaurant: String = "nhmt"
    @Published var username: String = "tr000001"
    @Published var password: String = "abc123"
 
    
    func getSession(){
       
        NetworkManager.callAPI(netWorkManger: .sessions){result in
            
            switch result {
                  case .success(let data):
                    
                        if let res = try? JSONDecoder().decode(APIResponse<String>.self, from: data) {
                            self.getConfig(sessionStr: res.data)
                            ManageCacheObject.deleteItem(Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT)
                        }else{
                            
                        }

                  case .failure(let error):
//                    self.utils.toastUtils.alertToast = AlertToast(type: .error(.red), title:"Error", subTitle:error.localizedDescription)
                    print(error)
            }
        }
    }
    
    func getConfig(sessionStr:String) {
        NetworkManager.callAPI(netWorkManger: .config(restaurant_name: restaurant)){result in
            
            
            switch result {
                  case .success(let data):
                    
                        if let res = try? JSONDecoder().decode(APIResponse<Config>.self, from: data) {
                            var config = res.data
                            config.api_key = String(format: "%@:%@", sessionStr, config.api_key ?? "")
                            ManageCacheObject.setConfig(config)
                            // call api login here...
                            self.login()
                            
                        }else{

                        }

                
                  case .failure(let error):
//                        self.utils.toastUtils.alertToast = AlertToast(type: .error(.red), title:"Error", subTitle:error.localizedDescription)
                        dLog(error)
            }
                       
        }
    }
    
    
    func login(){
        NetworkManager.callAPI(netWorkManger: .login(username: username, password: password)){result in
            
            switch result {
                  case .success(let data):
                    
                        guard let res = try? JSONDecoder().decode(APIResponse<Account>.self, from: data) else {
                            return
                        }
                        let data = res.data
                        dLog(res.data)
                        ManageCacheObject.saveUser(data)
                
                
                        var brand = Brand.init()
                        brand.id = data.restaurant_brand_id
                        brand.name = data.brand_name
                        brand.restaurant_id = data.restaurant_id
                        ManageCacheObject.setBrand(brand)
                    
    
                        SettingUtils.getSetting(
                            brandId: data.restaurant_brand_id,
                            branchId: data.branch_id ?? 0,
                            completion: {
                                dLog("Get setting success")
                                AppState.shared.userState = .loggedIn
                            },
                            incompletion:{
                                dLog("Get setting fail")
                                AppState.shared.userState = .notLoggedIn
                            }
                            
                        )
                    
                
                

                  case .failure(let error):
//                    self.utils.toastUtils.alertToast = AlertToast(type: .error(.red), title:"Error", subTitle:error.localizedDescription)
                      dLog(error)
            }
        }
    }
}




