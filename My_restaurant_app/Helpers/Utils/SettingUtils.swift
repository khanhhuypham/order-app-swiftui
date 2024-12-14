//
//  SettingUtils.swift
//  TECHRES-ORDER
//
//  Created by Pham Khanh Huy on 12/03/2024.
//



import UIKit

class SettingUtils {
    static private var completion:(()->Void)? = nil
    static private var incompletion:(()->Void)? = nil

    
    
    static func getSetting(brandId:Int, branchId:Int, completion:(()->Void)? = nil, incompletion:(()->Void)? = nil){
        self.completion = completion
        self.incompletion = incompletion
        self.getEmployeeSetting(step: 1,branchId: branchId)
    }
    
    static func getBranchSetting(branchId:Int, completion:(()->Void)? = nil,incompletion:(()->Void)? = nil){
        self.completion = completion
        self.incompletion = incompletion
        getEmployeeSetting(step: 2, branchId: branchId)
    }
    
    

    static private func getBrands(id:Int) {
        NetworkManager.callAPI(netWorkManger:.brands(status: ACTIVE)){result in
            
            switch result {
                case .success(let data):

                    guard let res = try? JSONDecoder().decode(APIResponse<[Brand]>.self, from: data) else{
                        (self.incompletion ?? {})()
                        return
                    }
                    let list = res.data
                    
          
                    if let brand = list.filter{$0.is_office == DEACTIVE}.first(where:{$0.id == id}){
                        ManageCacheObject.setBrand(brand)
                        self.getBrandSetting(brandId: brand.id ?? 0)
                    }
                
                
                case .failure(let error):
                    (self.incompletion ?? {})()
                    dLog(error)
            }
            
        }
        
    }
    
    
    
    
    static private func getBrandSetting(brandId:Int) {
        NetworkManager.callAPI(netWorkManger:.getBrandSetting(brand_id: brandId)){(result) in
            switch result {
                case .success(let data):
                    
                    guard let res = try? JSONDecoder().decode(APIResponse<BrandSetting>.self, from: data) else{
                        (self.incompletion ?? {})()
                        return
                    }
                
                  
                    var brand = Constants.brand
                    brand.setting = res.data
                    ManageCacheObject.setBrand(brand)
             
                   
                    
                case .failure(let error):
                    (self.incompletion ?? {})()
                dLog(error)
            }
        }
               
    }
    
    
    static private func getEmployeeSetting(step:Int,branchId:Int){
        
        let innerCompletion:((Branch?)->Void) = {data in
            guard let b = data else { return }
            var branch = Branch()
            branch.id = b.id
            branch.name = b.name
            branch.address = b.address
            branch.image_logo = b.image_logo_url
            branch.banner = b.banner_image_url
            ManageCacheObject.setBranch(branch)
       
            self.getPrinters(branchId: branchId)
            self.getPrivateBranchSetting(branchId: branchId)
            if step == 2{
                getBrandSetting(brandId: Constants.brand.id ?? 0)
            }
        }
        
        NetworkManager.callAPI(netWorkManger: .setting(branch_id: branchId)){result in
            
            switch result {
                case .success(let data):

                    guard let res = try? JSONDecoder().decode(APIResponse<AccountSetting>.self, from: data) else{
                        return
                    }
                    let setting = res.data
     
                    ManageCacheObject.saveAccountSetting(setting)
                
                    switch step{
                        case 1:
                            PermissionUtils.GPBH_1 ? innerCompletion(setting.branch) : self.fetBranches()

                        case 2:
                            innerCompletion(setting.branch)

                        default:
                            break
                    }
                
                
                case .failure(let error):
                
                dLog(error)
            }
            
        }
        
    
    }
    
    
    static private func fetBranches(){
        
        NetworkManager.callAPI(netWorkManger: .branches(brand_id: -1, status: 1)){result in
            
            switch result {
                case .success(let data):

                    guard let res = try? JSONDecoder().decode(APIResponse<[Branch]>.self, from: data) else{
                        return
                    }
                    let list = res.data.filter{$0.is_office == DEACTIVE}
                    
                 
                
                    if let branch = list.first{
                        ManageCacheObject.setBranch(branch)
                        getBrands(id: branch.restaurant_brand_id ?? 0)
                        getEmployeeSetting(step:2,branchId: branch.id ?? 0)
                    }else{
                        
                        ManageCacheObject.setBrand(Brand())
                        ManageCacheObject.setBranch(Branch())
//                        ManageCacheObject.setSetting(Setting())
                        ManageCacheObject.saveUser(Account())
                        ManageCacheObject.setConfig(Config())
//                        JonAlert.showError(message: "Bạn không có quyền truy cập ứng dụng này!", duration: 2.0)
                        dLog("error: ............")
                    }
                    
                
                case .failure(let error):
                
                dLog(error)
            }
        }
    
    }
//
//
    static private func getPrinters(branchId:Int){
       
    }
    
    static private func getPrivateBranchSetting(branchId:Int) {
        
        
        NetworkManager.callAPI(netWorkManger: .getApplyOnlyCashAmount(branchId: branchId)){result in
            switch result {
                case .success(let data):

                    guard let res = try? JSONDecoder().decode(APIResponse<PaymentMethod>.self, from: data) else{
                        return
                    }
                    //general-setting
                    (self.completion ?? {})()
                        
                case .failure(let error):
                
                dLog(error)
            }
            
        }
        
    }
//
}

