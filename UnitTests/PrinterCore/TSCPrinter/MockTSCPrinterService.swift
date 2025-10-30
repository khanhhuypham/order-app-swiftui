//
//  MockOrderService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 27/10/25.
//

@testable import My_restaurant_app
import UIKit

final class MockTSCPrinterService: PrinterCoreProtocol {
    
    var id: String = UUID().uuidString
    
    func connect() async throws {
        
    }
    
    func disconnect() {
        
    }
    
    func print(data: Data) async throws {
        
    }
    
    func printBitMap(id: String, printer: Printer, img: UIImage, isLastItem: Bool) {
        
    }
    

  

}

