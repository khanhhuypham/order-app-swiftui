//
//  WIFIQueuedItem.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//

import UIKit
import Foundation
struct POSQueuedItem{
    var id:UUID
    var data:Data
    var items:[Food]
    var printer:Printer
    var isLastItem:Bool
    var isFinished:Bool
    var printMode:PRINT_MODE
    
//    init(wifiQueuedItem:WIFIQueuedItemObject){
//        
//        self.id = wifiQueuedItem.id
//        self.data = wifiQueuedItem.data
//        var arr:[Food] = []
//        for item in wifiQueuedItem.items{
//            arr.append(Food(itemObject: item))
//        }
//        self.items = arr
//        
//        if let printer = wifiQueuedItem.printer{
//            self.printer = Printer(printerObject:printer)
//        }else{
//            self.printer = Printer()
//        }
//       
//        self.isLastItem = wifiQueuedItem.isLastItem
//        self.isFinished = wifiQueuedItem.isFinished
//        self.printMode = wifiQueuedItem.printMode
//    }
}



struct TSCQueuedItem{
    var id:UUID
    var data:[Data]
    var printer:Printer
    var isLastItem:Bool
    var isFinished:Bool
    var printMode:PRINT_MODE
    
//    init(tscQueuedItem:TSCQueuedItemObject){
//        self.id = tscQueuedItem.id
//        var arr:[Data] = []
//        for data in tscQueuedItem.data{
//            arr.append(data)
//        }
//        self.data = arr        
//        if let printer = tscQueuedItem.printer{
//            self.printer = Printer(printerObject:printer)
//        }else{
//            self.printer = Printer()
//        }
//       
//        self.isLastItem = tscQueuedItem.isLastItem
//        self.isFinished = tscQueuedItem.isFinished
//        self.printMode = tscQueuedItem.printMode
//    }
}







