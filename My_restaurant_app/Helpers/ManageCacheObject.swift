//
//  ManageCacheObject.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//


import UIKit


public class ManageCacheObject {
    // MARK: - setConfig
    static func deleteItem(_ key: String){
        
        UserDefaults.standard.removeObject(forKey: key)
        
      
    }
    
    // MARK: - setConfig
    static func setConfig(_ config: Config){
        
        if let configJSON = try? JSONEncoder().encode(config) {
            UserDefaults.standard.set(configJSON, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_CONFIG)
        }
        
      
    }
    
    static func getConfig() -> Config?{
        
        if let data = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_CONFIG) as? Data {
        
            if let savedConfig = try? JSONDecoder().decode(Config.self, from: data) {
                return savedConfig
            }
        }
        return nil
        
    }
    
   
//    static func setSetting(_ setting : Setting) {
//        
//        if let json = try? JSONEncoder().encode(setting) {
//         
//            UserDefaults.standard.set(json, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_SETTING)
//        }
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getSetting() -> Setting{
//        
//        if let data = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_SETTING) as? Data {
//        
//            if let setting = try? JSONDecoder().decode(Setting.self, from: data) {
//                return setting
//            }
//        }
//        return Setting()
//        
//    }
    
    
    
    static func saveUser(_ user : Account) {
        
        if let json = try? JSONEncoder().encode(user) {
         
            UserDefaults.standard.set(json, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT)
        }
        UserDefaults.standard.synchronize()
    }
    
    static func getUser() -> Account?{

        
        if let data = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT) as? Data {
            if let user = try? JSONDecoder().decode(Account.self, from: data) {
                return user
            }
        }
        return nil
        
    }
    
    
    
    

    static func saveAccountSetting(_ setting : AccountSetting) {
        
        if let json = try? JSONEncoder().encode(setting) {
         
            UserDefaults.standard.set(json, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT_SETTING)
        }
        UserDefaults.standard.synchronize()
    }
    
    static func getAccountSetting() -> AccountSetting?{

        
        if let data = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT_SETTING) as? Data {
            if let setting = try? JSONDecoder().decode(AccountSetting.self, from: data) {
                return setting
            }
        }
        return nil
        
    }


    
    // MARK: - PUSH_TOKEN
    static func setPushToken(_ push_token:String){
        UserDefaults.standard.set(push_token, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PUSH_TOKEN)
    }
    
    static func getPushToken()->String{
        if let push_token : String = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PUSH_TOKEN) as? String{
            return push_token
        }else{
            return ""
        }
    }

    public static func isLogin()->Bool{
        if let account = ManageCacheObject.getUser(),account.id != 0{
            return true
        }else{
            return false
        }
        
    }
    
    
    static func setBranch(_ branch : Branch) {
        
        if let json = try? JSONEncoder().encode(branch) {
         
            UserDefaults.standard.set(json, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_BRANCH)
        }
        
        
    }
    
    static func getBranch() -> Branch? {
        
        
        if let data = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_BRANCH) as? Data {
            if let branch = try? JSONDecoder().decode(Branch.self, from: data) {
                return branch
            }
        }
        return nil
    }
        
    static func setBrand(_ brand : Brand) {
     
        
        if let json = try? JSONEncoder().encode(brand) {
         
            UserDefaults.standard.set(json, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_BRAND)
        }
        
    }
    
    static func getBrand() -> Brand?{
   
        if let data = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_BRAND) as? Data {
            if let brand = try? JSONDecoder().decode(Brand.self, from: data) {
                return brand
            }
        }
        return nil
    }
    
    
    
//    static func setPaymentMethod(_ paymentMethod: PaymentMethod) {
//        UserDefaults.standard.set(Mapper<PaymentMethod>().toJSON(paymentMethod), forKey:Constants.KEY_DEFAULT_STORAGE.KEY_PAYMENT_METHOD)
//    }
//    
//    static func getPaymentMethod() -> PaymentMethod {
//        if let method  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PAYMENT_METHOD){
//            return Mapper<PaymentMethod>().map(JSONObject: method)!
//        }else{
//            return PaymentMethod.init()
//        }
//    }
    
    
//    static func setOrderMethod(_ orderMethod: OrderMethod) {
//        UserDefaults.standard.set(Mapper<OrderMethod>().toJSON(orderMethod), forKey:Constants.KEY_DEFAULT_STORAGE.KEY_ORDER_METHOD)
//    }
//    
//    static func getOrderMethod() -> OrderMethod {
//        if let method  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_ORDER_METHOD){
//            return Mapper<OrderMethod>().map(JSONObject: method)!
//        }else{
//            return OrderMethod.init()
//        }
//    }
//    
    
    static func setIdleTimerStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_IDLE_TIMER)
    }
    
    static func getIdleTimerStatus() -> Bool {
        if let status  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_IDLE_TIMER){
            return status as! Bool
        }else{
            return false
        }
    }
    

    static func setIsDevMode(_ isDevMode: Bool){
        UserDefaults.standard.set(isDevMode, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_DEV_MODE)
    }
    
    static func isDevMode()->Bool{
        let isDevMode : Bool = UserDefaults.standard.bool(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_DEV_MODE)
        return isDevMode
    }

}
