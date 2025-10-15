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
        do {
            // 🧩 Call the API asynchronously
            let res: APIResponse<[Brand]> = try await NetworkManager.callAPIAsync(netWorkManger: .brands(status: ACTIVE))
            
            // 🛑 Validate status
            guard res.status == .ok else {
                (self.incompletion ?? {})()
                return
            }
            
            // 🧩 Find the matching brand
            guard let brand = res.data.filter({ $0.is_office == DEACTIVE }).first(where: { $0.id == id }) else {
                (self.incompletion ?? {})()
                dLog("⚠️ Brand not found for id: \(id)")
                return
            }
            
            // ✅ Save and continue
            ManageCacheObject.setBrand(brand)
            await self.getBrandSetting(brandId: brand.id)
            
        } catch {
            (self.incompletion ?? {})()
            dLog("Error: \(error)")
        }
    }

    

    static func getBrandSetting(brandId: Int) async {
        do {
            // 🧩 Await async API call
            let res: APIResponse<BrandSetting> = try await NetworkManager.callAPIAsync(netWorkManger: .getBrandSetting(brand_id: brandId))
            
            // 🧩 Check response
            guard res.status == .ok else {
                (self.incompletion ?? {})()
                return
            }

            // ✅ Update brand and cache
            var brand = Constants.brand
            brand.setting = res.data
            ManageCacheObject.setBrand(brand)

        } catch {
            (self.incompletion ?? {})()
            dLog("Error: \(error)")
        }
    }

    
    
    static private func getEmployeeSetting(step: Int, branchId: Int) async {
        do {
            // 🧩 Call API
            let result: APIResponse<AccountSetting> = try await NetworkManager.callAPIAsync(netWorkManger: .setting(branch_id: branchId))

            // 🛑 Validate response
            guard result.status == .ok else {
                (self.incompletion ?? {})()
                return
            }

            // ✅ Save account setting
            ManageCacheObject.saveAccountSetting(result.data)

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
                    await PermissionUtils.GPBH_1 ? innerCompletion(result.data.branch) : fetBranches()

                case 2:
                    await innerCompletion(result.data.branch)

                default:
                    break
            }

        } catch {
            (self.incompletion ?? {})()
            dLog("Error: \(error)")
        }
    }


    
  
    static func fetBranches() async {
        do {
            // Call the API using async version
            let res: APIResponse<[Branch]> = try await NetworkManager.callAPIAsync(netWorkManger: .branches(brand_id: -1, status: 1))
            
            // Check status
            guard res.status == .ok else {
                (self.incompletion ?? {})()
                return
            }
            
            let list = res.data.filter { $0.is_office == DEACTIVE }
            
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
            
        } catch {
            (self.incompletion ?? {})()
            dLog("Error: \(error)")
        }
    }



    static func getPrinters(branchId: Int) async {
        do {
            let res: APIResponse<[Printer]> = try await NetworkManager.callAPIAsync(netWorkManger: .getPrinters(branch_id: branchId, status: -1))
            if res.status == .ok {
               
//                ManageCacheObject.setPrinter(res.data)
            }
        } catch {
            dLog("Error fetching printers: \(error)")
        }
    }
    
    
    
    static func getPrivateBranchSetting(branchId: Int) async {
        do {
            let res: APIResponse<PaymentMethod> = try await NetworkManager.callAPIAsync(netWorkManger: .getApplyOnlyCashAmount(branchId: branchId))
            
            // You can handle the response here if needed
//             e.g. ManageCacheObject.setPaymentMethod(res.data)
            
            (self.completion ?? {})()
        } catch {
            (self.incompletion ?? {})()
            dLog("Error: \(error)")
        }
    }

}

