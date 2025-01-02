//
//  PrinterSettingViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 16/12/2024.
//

import SwiftUI


class PrinterSettingViewModel: ObservableObject {
    @Published var printers:[Printer] = []
    
    func getPrinters(){

        NetworkManager.callAPI(netWorkManger:.getPrinters(branch_id: 0)){[weak self] result in

            guard let self = self else { return }

            switch result {
                case .success(let data):

                    guard var res = try? JSONDecoder().decode(APIResponse<[Printer]>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                   
                    printers = res.data
                
                  


                case .failure(let error):
                    print(error)
            }
        }
    }
    

}
