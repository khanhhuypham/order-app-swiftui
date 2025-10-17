//
//  PrinterSettingViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/12/2024.
//

import SwiftUI


class PrinterListViewModel: ObservableObject {
    @Published var printers:[Printer] = []
    var foodAppPrinter: Bool = false

    @MainActor
    func getPrinters() async {
        
        let result: Result<APIResponse<[Printer]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .getPrinters(branch_id: Constants.branch.id)
        )
        
        switch result {
            case .success(let res):
                if res.status == .ok, let data = res.data{
                    printers = data
                }
         

            case .failure(let error):
                dLog("❌ Orders API failed: \(error)")
        }
    }
    

}
