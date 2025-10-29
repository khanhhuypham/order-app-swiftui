//
//  MockOrderService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 27/10/25.
//

@testable import My_restaurant_app
import Foundation
import UIKit

final class MockPOSPrinterService: PrinterCoreProtocol {
    
    var id: String = UUID().uuidString
    
    func connect() async throws {
        <#code#>
    }
    
    func disconnect() {
        <#code#>
    }
    
    func print(data: Data) async throws {
        <#code#>
    }
    
    func printBitMap(id: String, printer: Printer, img: UIImage, isLastItem: Bool) {
        <#code#>
    }
    

  

}

