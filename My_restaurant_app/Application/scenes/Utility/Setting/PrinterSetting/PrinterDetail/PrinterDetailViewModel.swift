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
        
        NetworkManager.callAPI(netWorkManger:.updatePrinter(branch_id: Constants.branch.id, printer: printer)){[weak self] (result: Result<PlainAPIResponse, Error>) in

            guard let self = self else { return }

            switch result {
                case .success(let res):
                    
                    if (res.status == .ok) {
                        
                        navigateTag = 1
                    
                    }
                  
                
            
                case .failure(let error):
                    print(error)
            }
        }
    }
}
