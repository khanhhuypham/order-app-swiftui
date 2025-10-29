//
//  TSCPrinter 2.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//
import Foundation
import UIKit

final class BLEPrinter: PrinterCoreProtocol {

    let id: String
    let name: String
    private let host: String
    private let port: Int

    init(id: String, name: String, host: String, port: Int) {
        self.id = id
        self.name = name
        self.host = host
        self.port = port
    }
    
    // MARK: - Connection
    
    func connect() async throws {
       
    }
    
    func disconnect() {
    
    }
    
    func print(data: Data) async throws {
        
    }
    
    func printBitMap(id: String, printer: Printer, img: UIImage, isLastItem: Bool) {
        
    }
     
 }
