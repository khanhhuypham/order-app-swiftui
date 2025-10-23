//
//  FoodManagementViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 23/10/2024.
//

import SwiftUI
import Combine
class FoodManagementViewModel: ObservableObject {
    let branchId = Constants.branch.id
    let brandId = Constants.brand.id
    

    @Published var tab = 0
    @Published var tabArray:[(id:Int,title:String,isSelect:Bool)] = [
        (id:0,title:"MÓN THƯỜNG",isSelect:true),
        (id:1,title:"BÁN KÈM / TOPPING",isSelect:false),
    ]
    
    @Published var text: String = ""
    @Published var data:[Food] = []
    var fullList:[Food] = []
    
    
    private var cancellables = Set<AnyCancellable>()
    init() {

          $text
//              .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
          .removeDuplicates()
          .sink { [weak self] keyWord in
              
              if !keyWord.isEmpty {
                  let filteredDataArray = self?.fullList.filter({(value) -> Bool in
                      let str1 = keyWord.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                      let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
        
                      return str2.contains(str1)
                  })
                  self?.data = filteredDataArray ?? []
              }else{
                  self?.data = self?.fullList ?? []
              }
          }
          .store(in: &cancellables)
      }

}

//MARK: categories
extension FoodManagementViewModel{
    
    @MainActor
    func getFood(isAddition:Int) async{
        
        
        let result: Result<APIResponse<[Food]>, Error> = await NetworkManager.callAPIResultAsync(
            netWorkManger: .foodsManagement(branch_id:branchId, is_addition: isAddition,status: ALL)
        )
        
        switch result {

            case .success(let res):
                if res.status == .ok{
                    data = res.data ?? []
                    fullList = res.data ?? []
                }
             
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    


}
