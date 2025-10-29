//
//  LocalDataBaseUtils.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//


protocol LocalDBServiceProtocol {
    func removeAllQueuedItem()
    func CheckFinishedQueuedItem()
    
    //MARK: PRINTER
    func savePrinters(printersArray:[Printer])
    func updatePrinters(printersArray:[Printer])
    func removePrinters()
    
    //MARK: TSC
//    func saveTSCDataToDB(orderId:Int,printer:Printer,imgs:[UIImage],isLastItem:Bool,printMode:PRINT_MODE)
//    func UpdateRetryNumberOfTSCQueuedItem(id:ObjectId)
//    func UpdateTSCQueuedItemToFinish(id:ObjectId?)
//    func getTSCQueuedItemById(id:ObjectId) -> TSCQueuedItemObject?
//    func getForegroundTSCQueuedItem() -> [TSCQueuedItemObject]
//    func getFirstTSCQueuedItem() -> TSCQueuedItemObject?
//    func removeTSCQueuedItemByOrderId(orderId:Int)
//    func removeTSCQueuedItemById(id:ObjectId)
//    
//    //MARK: POS
//    func getFirstPOSQueuedItem() -> WIFIQueuedItemObject?
//    func getForegroundPOSQueuedItem() -> [WIFIQueuedItemObject]
//    func getQueuedPOSItemById(id:ObjectId) -> WIFIQueuedItemObject?
//    func isOrderPerformingPrintProcess(orderId:Int) -> Bool
//    func UpdateRetryNumber(id:ObjectId)
//    func UpdateWifiQueuedItemToFinish(id:ObjectId?)
//    func removeWifiQueuedItemByOrderId(orderId:Int)
//    func removePOSQueuedItemById(id:ObjectId)
}
