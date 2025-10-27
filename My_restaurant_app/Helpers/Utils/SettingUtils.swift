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

    
    
    static func getSetting(brandId:Int, branchId:Int, completion:(()->Void)? = nil, incompletion:(()->Void)? = nil) async{
        self.completion = completion
        self.incompletion = incompletion
        await self.getEmployeeSetting(step: 1,branchId: branchId)
    }
    
    static func getBranchSetting(branchId:Int, completion:(()->Void)? = nil,incompletion:(()->Void)? = nil) async{
        self.completion = completion
        self.incompletion = incompletion
        await getEmployeeSetting(step: 2, branchId: branchId)
    }
    
    

    
    static func getBrands(id: Int) async {
        
        // 🧩 Call the API asynchronously
        let result:Result<APIResponse<[Brand]>,Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .brands(status: ACTIVE))

        switch result {
           case .success(let res):
                guard res.status == .ok,let data = res.data else {
                    (self.incompletion ?? {})()
                    return
                }
               // 🧩 Find the matching brand
               guard let brand = data.filter({ $0.is_office == DEACTIVE }).first(where: { $0.id == id }) else {
                   (self.incompletion ?? {})()
                   dLog("⚠️ Brand not found for id: \(id)")
                   return
               }
               
               // ✅ Save and continue
               ManageCacheObject.setBrand(brand)
               await self.getBrandSetting(brandId: brand.id)
               break
                 
           case .failure(let error):
               (self.incompletion ?? {})()
               break

        }
    }

    

    static func getBrandSetting(brandId: Int) async {
        // 🧩 Await async API call
        let result:Result<APIResponse<BrandSetting>,Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getBrandSetting(brand_id: brandId))
        
        switch result {
            case .success(let res):
                // 🧩 Check response
                guard res.status == .ok,let data = res.data else {
                    (self.incompletion ?? {})()
                    return
                }
                
                // ✅ Update brand and cache
                var brand = Constants.brand
                brand.setting = data
                ManageCacheObject.setBrand(brand)
            
            case .failure(let error):
                (self.incompletion ?? {})()
                dLog("Error: \(error)")
                break

            
        }
      
    }

    
    
    static private func getEmployeeSetting(step: Int, branchId: Int) async {
        // 🧩 Call API
        let result:Result<APIResponse<AccountSetting>,Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .setting(branch_id: branchId))
        
        switch result {
            case .success(let res):
                // 🛑 Validate response
                guard res.status == .ok,let data = res.data else {
                    (self.incompletion ?? {})()
                    return
                }
                
                // ✅ Save account setting
                ManageCacheObject.saveAccountSetting(data)
                
                // 🧩 Define innerCompletion as async function
                func innerCompletion(_ data: Branch?) async {
                    guard let b = data else { return }
                    
                    var branch = Branch()
                    branch.id = b.id
                    branch.name = b.name
                    branch.address = b.address
                    branch.image_logo = b.image_logo_url
                    branch.banner = b.banner_image_url
                    ManageCacheObject.setBranch(branch)
                    
                    // 🧩 Sequential async calls
                    await self.getPrinters(branchId: branchId)
                    await self.getPrivateBranchSetting(branchId: branchId)
                    
                    // Step 2: Load brand setting
                    guard step == 2 else { return }
                    await getBrandSetting(brandId: Constants.brand.id)
                }
                
                // 🧩 Handle step logic
                switch step {
                    case 1:
                        await PermissionUtils.GPBH_1 ? innerCompletion(data.branch) : fetBranches()
                        
                    case 2:
                        await innerCompletion(data.branch)
                        
                    default:
                        break
                }
            
            case .failure(let error):
                (self.incompletion ?? {})()
                dLog("Error: \(error)")
                break
        }
        
    }


    
  
    static func fetBranches() async {
        // Call the API using async version
        let result:Result<APIResponse<[Branch]>,Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .branches(brand_id: -1, status: 1))
            
        switch result {
            case .success(let res):
                // Check status
                guard res.status == .ok,let data = res.data else {
                    (self.incompletion ?? {})()
                    return
                }
                
                let list = data.filter { $0.is_office == DEACTIVE }
                
                if let branch = list.first {
                    ManageCacheObject.setBranch(branch)
                    
                    // Sequential calls
                    await getBrands(id: branch.restaurant_brand_id)
                    await getEmployeeSetting(step: 2, branchId: branch.id)
                    
                } else {
                    // Handle missing branch
                    ManageCacheObject.setBrand(Brand())
                    ManageCacheObject.setBranch(Branch())
                    ManageCacheObject.saveUser(Account())
                    ManageCacheObject.setConfig(Config())
                    dLog("error: ............")
                }
                
            case .failure(let error):
                (self.incompletion ?? {})()
                dLog("Error: \(error)")
                break
        }

    }



    static func getPrinters(branchId: Int) async {
        let result:Result<APIResponse<[Printer]>,Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getPrinters(branch_id: branchId, status: -1))
        
        switch result {
            case .success(let res):
                // Check status
                guard res.status == .ok,let data = res.data else {
                    (self.incompletion ?? {})()
                    return
                }
                
               
            case .failure(let error):
                (self.incompletion ?? {})()
                dLog("Error: \(error)")
                break
        }
    }
    
    
    
    static func getPrivateBranchSetting(branchId: Int) async {
        let result:Result<APIResponse<PaymentMethod>,Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getApplyOnlyCashAmount(branchId: branchId))
        
        switch result {
            case .success(let res):
                break
            
            case .failure(let error):
                (self.incompletion ?? {})()
                dLog("Error: \(error)")
                break
        }
    }

}

