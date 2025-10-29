//
//  LocalDataBaseService + extension.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//

import UIKit

extension LocalDBService {
    
    func getFirstPOSQueuedItem() -> POSQueuedItem? {
        return nil
    }
    
    func getForegroundPOSQueuedItem() -> [POSQueuedItem] {
        return []
    }
    
    func getQueuedPOSItemById(id: UUID) -> POSQueuedItem? {
        return nil
    }
    

    func UpdateRetryNumber(id: UUID) {
        
    }
    
    func UpdatePOSQueuedItemToFinish(id: UUID) {
        
    }
    
    func removePOSQueuedItemById(id: UUID) {
        
    }
}
