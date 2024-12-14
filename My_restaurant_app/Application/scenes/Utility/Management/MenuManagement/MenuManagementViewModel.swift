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

//MARK: categories
//extension MenuManagementViewModel{
//    func getCategories(){
//        
//        NetworkManager.callAPI(netWorkManger:.categories(brand_id:brandId,status:-1)){[weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                case .success(let data):
//
//                    guard var res = try? JSONDecoder().decode(APIResponse<[Area]>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//
//
//                case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}


//MARK: food
//extension MenuManagementViewModel{
//    func getFoods(){
//        
//        NetworkManager.callAPI(netWorkManger:.foodsManagement(branch_id:branchId, is_addition: DEACTIVE,status: -1)){[weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                  case .success(let data):
//                        
//                    guard var res = try? JSONDecoder().decode(APIResponse<[Area]>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//                    
//                  
//                  case .failure(let error):
//                      print(error)
//            }
//        }
//    }
//}

//
////MARK: note
//extension MenuManagementViewModel{
//    
//    func getNotes(){
//        
//        NetworkManager.callAPI(netWorkManger:.notesManagement(branch_id:branchId,status: ACTIVE)){[weak self] result in
//            
//            guard let self = self else { return }
//            
//            switch result {
//                  case .success(let data):
//                        
//                    guard var res = try? JSONDecoder().decode(APIResponse<[Area]>.self, from: data) else{
//                        dLog("Parse model sai")
//                        return
//                    }
//                    
//                  
//            
//                  case .failure(let error):
//                      print(error)
//            }
//        }
//    }
//   
//    
//}
