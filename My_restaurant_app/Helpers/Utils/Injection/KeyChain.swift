//
//  KeyChainUtils.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 14/10/25.
//

import Security
import LocalAuthentication


struct KeychainKey {
    let service: String
    let account: String
}

class KeyChain {
    

    let accessTokenKey = KeychainKey(service: "com.myApp.auth", account: "accessToken")
    let passwordKey = KeychainKey(service: "com.myApp.auth", account: "userPassword")
}

extension KeyChain{
    
    func savePassword(password: String) -> Bool {
        let data = password.data(using: .utf8)!
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: passwordKey.service,
            kSecAttrAccount: passwordKey.account,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query) // Delete any existing item
        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }
    
    func getPassword() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: passwordKey.service,
            kSecAttrAccount: passwordKey.account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        guard status == errSecSuccess else { return nil }
        guard let data = dataTypeRef as? Data else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Check if biometric authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access sensitive data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            // Biometric authentication is not available
            completion(false, error)
        }
    }
    
    
    func savePasswordWithBiometrics(password: String) -> Bool {
        let data = password.data(using: .utf8)!
        
        // Create the access control object
        let accessControl = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            .userPresence,
            nil
        )
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: passwordKey.service,
            kSecAttrAccount: passwordKey.account,
            kSecValueData: data,
            kSecAttrAccessControl: accessControl as Any
        ] as CFDictionary
        
        SecItemDelete(query) // Delete any existing item
        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }
    
    
    
    func getPasswordWithBiometrics(completion: @escaping (String?) -> Void) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: passwordKey.service,
            kSecAttrAccount: passwordKey.account,
            kSecReturnData: true,
            kSecUseOperationPrompt: "Authenticate to access your password",
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        
        DispatchQueue.global().async {
            let status = SecItemCopyMatching(query, &dataTypeRef)
            
            DispatchQueue.main.async {
                guard status == errSecSuccess, let data = dataTypeRef as? Data, let password = String(data: data, encoding: .utf8) else {
                    completion(nil)
                    return
                }
                completion(password)
            }
        }
    }
}
    


//MARK: accessToken
extension KeyChain{
    func saveAccessToken(accessToken: String) -> Bool {
        guard let data = accessToken.data(using: .utf8) else { return false }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: accessTokenKey.service,
            kSecAttrAccount: accessTokenKey.account,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query) // Delete any existing item
        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }
    
    func getAccessToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: accessTokenKey.service,
            kSecAttrAccount: accessTokenKey.account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data, let token = String(data: data, encoding: .utf8)else {
               return nil
        }
           
        return token
    }
    
}
    
