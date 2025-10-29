//
//  PrinterUtilServiceProtocols.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//

import UIKit


protocol PrinterProtocol {
    var id: String { get }
    func connect() async throws
    func disconnect()
    func print(data: Data) async throws
    func printBitMap(id:String,printer:Printer,img:UIImage,isLastItem:Bool)
}



protocol PrinterCommandBuilderProtocol {
    func buildOrderCommand(order: OrderDetail) -> Data
}
