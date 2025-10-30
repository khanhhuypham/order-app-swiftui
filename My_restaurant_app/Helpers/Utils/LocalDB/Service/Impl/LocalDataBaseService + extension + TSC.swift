//
//  LocalDataBaseService + extension.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//

import UIKit

extension LocalDBService {
    
    func saveTSCDataToDB(orderId: Int, printer: Printer, imgs: [UIImage], isLastItem: Bool, printMode: PRINT_MODE) {
        
    }
    
    func UpdateRetryNumberOfTSCQueuedItem(id: UUID) {
        
    }
    
    func UpdateTSCQueuedItemToFinish(id: UUID?) {
        
    }
    
    func getTSCQueuedItemById(id: UUID) -> TSCQueuedItem? {
        return nil
    }
    
    func getForegroundTSCQueuedItem() -> [TSCQueuedItem] {
        return []
    }
    
    func getFirstTSCQueuedItem() -> TSCQueuedItem? {
        return nil
    }
    
    func removeTSCQueuedItemById(id: UUID) {
        
    }
}
