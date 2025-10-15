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
    
    func getPrinters(){

        NetworkManager.callAPI(netWorkManger:.getPrinters(branch_id: Constants.branch.id)){[weak self] (result: Result<APIResponse<[Printer]>, Error>) in

            guard let self = self else { return }

            switch result {
                case .success(let res):
                    
                    if (res.status == .ok) {
                        
                        printers = res.data
                    
                    }
                  
                
            
                case .failure(let error):
                    print(error)
            }
        }
    }
    

}
