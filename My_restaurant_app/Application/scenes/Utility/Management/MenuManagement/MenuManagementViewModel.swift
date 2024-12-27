//
//  MenuManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 12/10/2024.
//


import SwiftUI


class MenuManagementViewModel: ObservableObject {
 
    @Published var tab = 1
    @Published var tabArray:[(id:Int,title:String,isSelect:Bool)] = [
        (id:1,title:"DANH MỤC",isSelect:false),
        (id:2,title:"MÓN ĂN",isSelect:false),
        (id:3,title:"GHI CHÚ",isSelect:false)
    ]
    
    let branchId = Constants.branch.id ?? 0
    let brandId = Constants.brand.id ?? 0
    

    
}

