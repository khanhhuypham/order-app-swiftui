//
//  OrderListViewModel + extension + socket.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 27/9/25.
//


extension OrderDetailViewModel {
    
    @MainActor
    func updateAlreadyPrinted(ids:[Int])async{
        let result = await service.updateAlreadyPrinted(orderId: order.id, order_detail_ids: ids)
        
        switch result {
            case .success(let res):
                for id in ids {
                    printItems.removeAll(where: {$0.id == id})
                    if let index = order.orderItems.firstIndex(where: { $0.id == id }) {
                        order.orderItems[index].status = .done
                    }
                }
               break
            case .failure(let error):
               dLog("Error: \(error)")
        }
        
    }


    func print(items:[PrintItem], printType:Constants.printType) {
        
        var printers = Constants.printers.filter{$0.type == .bar || $0.type == .chef}
        var itemSendToPrinter:[PrintItem] = []
        var itemSendToServer:[PrintItem] = []
        
        for printer in printers.filter{$0.active}{
            itemSendToPrinter += items.filter{$0.printer_id == printer.id}
        }
        
        itemSendToServer += items
        
        //check whether tsc printer has the same name as other wifi printer, in order to avoid error
//        let valid = PrinterUtils.shared.checkValidPrinters(presenter: self)
//        
//        if !valid{
//            return
//        }
        
        if itemSendToServer.count > 0{
            Task{
                await updateAlreadyPrinted(ids: itemSendToServer.map{$0.id})
            }
        }
        
        // we insert stamp printer to print stamp for items which is allow to print stamp
//        if let stampPrinter = Constants.printers.filter{$0.type == .stamp}.filter{$0.is_have_printer == ACTIVE}.first{
//            printers.append(stampPrinter)
//            
//            for (i,_) in itemSendToPrinter.enumerated() {
//                if itemSendToPrinter[i].is_allow_print_stamp == ACTIVE{
//                    
//                    itemSendToPrinter[i].TSCPrinter_id = stampPrinter.id
//                    
//                }
//            }
//            
//        }
//        

//        if itemSendToPrinter.count > 0 && printers.filter{$0.is_have_printer == ACTIVE}.count > 0{
//            
//            PrinterUtils.shared.PrintItems(
//                presenter: self,
//                order:viewModel.order.value,
//                printItem:itemSendToPrinter,
//                printers:printers,
//                printMode:viewModel.order.value.order_method == .TAKE_AWAY ? .printBackgroundWithoutRetry : .printForeground,
//                completetHandler: {
//                    self.getOrder()
//                }
//            )
//
//        }
    }
    
}
