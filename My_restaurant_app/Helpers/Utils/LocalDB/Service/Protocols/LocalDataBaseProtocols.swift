//
//  LocalDataBaseUtils.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//

import Foundation
import UIKit


protocol LocalDBServiceProtocol {
    func removeAllQueuedItem()
    func CheckFinishedQueuedItem()
    
    //MARK: PRINTER
    func savePrinters(printersArray:[Printer])
    func updatePrinters(printersArray:[Printer])
    func removePrinters()
    
    //MARK: TSC
    func saveTSCDataToDB(orderId:Int,printer:Printer,imgs:[UIImage],isLastItem:Bool,printMode:PRINT_MODE)
    func UpdateRetryNumberOfTSCQueuedItem(id:UUID)
    func UpdateTSCQueuedItemToFinish(id:UUID?)
    func getTSCQueuedItemById(id:UUID) -> TSCQueuedItem?
    func getForegroundTSCQueuedItem() -> [TSCQueuedItem]
    func getFirstTSCQueuedItem() -> TSCQueuedItem?
    func removeTSCQueuedItemById(id:UUID)

//    //MARK: POS
    func getFirstPOSQueuedItem() -> POSQueuedItem?
    func getForegroundPOSQueuedItem() -> [POSQueuedItem]
    func getQueuedPOSItemById(id:UUID) -> POSQueuedItem?
    func UpdateRetryNumber(id:UUID)
    func UpdatePOSQueuedItemToFinish(id:UUID)
    func removePOSQueuedItemById(id:UUID)
}
