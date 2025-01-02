//
//  PrinterDetailViewModel.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 01/01/2025.
//

import UIKit

class PrinterDetailViewModel:ObservableObject {
    @Published var printer:Printer = Printer()
    @Published var navigateTag:Int? = -1
    
    func updatePrinter(){
        
        NetworkManager.callAPI(netWorkManger:.updatePrinter(printer: printer)){[weak self] result in

            guard let self = self else { return }

            switch result {
                case .success(let data):

                    guard var res = try? JSONDecoder().decode(APIResponse<Printer>.self, from: data) else{
                        dLog("Parse model sai")
                        return
                    }
                    navigateTag = 1
                    
            
                case .failure(let error):
                    print(error)
            }
        }
       
    }
}
