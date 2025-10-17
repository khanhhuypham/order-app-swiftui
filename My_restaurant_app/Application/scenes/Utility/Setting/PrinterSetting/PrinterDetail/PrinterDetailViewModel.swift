//
//  PrinterDetailViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 01/01/2025.
//

import UIKit

class PrinterDetailViewModel:ObservableObject {
    @Published var printer:Printer = Printer()
    @Published var navigateTag:Int? = nil

    
    
    @MainActor
    func updatePrinter() async {
        
        let result: Result<PlainAPIResponse, Error> = await NetworkManager.callAPIResultAsync(
                netWorkManger: .updatePrinter(branch_id: Constants.branch.id, printer: printer)
        )
        
        switch result {
            case .success(let res):
                if res.status == .ok  {
                    navigateTag = 1
                }
         

            case .failure(let error):
                dLog("❌ Orders API failed: \(error)")
        }
    }


}
