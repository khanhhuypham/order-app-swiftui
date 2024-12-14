//
//  FoodViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI
import Combine

class FoodViewModel: ObservableObject {
    @Published var navigateTag:Int? = -1
    
    @Published var order:OrderDetail = OrderDetail()
    
    @Published var categories:[Category] = []
    
    @Published var foods:[Food] = []
    
    @Published var buffets:[Buffet] = []
    
    public var selectedFoods:[Food] = []
    
    public var selectedBuffet:Buffet? = nil
    
    @Published var APIParameter : (
        category_id:Int,
        category_type:FOOD_CATEGORY,
        is_allow_employee_gift:Int,
        is_sell_by_weight:Int,
        is_out_stock:Int,
        is_use_point:Int,
        key_word:String,
        limit:Int,
        page:Int,
        total_record:Int,
        buffet_ticket_id:Int?
    ) =  (
            category_id:-1,
            category_type:.all,
            is_allow_employee_gift:-1,
            is_sell_by_weight:ALL,
            is_out_stock:-1,
            is_use_point:0,
            key_word:"",
            limit:50,
            page:1,
            total_record:2,
            buffet_ticket_id:nil
        )
    
    @Published public var showPopup:(
        show:Bool,
        PopupType:popupType,
        item:Food?
    ) = (false,.cancel,nil)
   
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - PAGINATION
    func loadMoreContent(currentItem item: Food){

        if self.foods.endIndex < APIParameter.total_record {
            APIParameter.page += 1
            getFoods()
        }
        
    }
    
    //MARK: - PAGINATION
    func reloadContent(){
        APIParameter.page = 1
        foods.removeAll()
        buffets.removeAll()
        switch APIParameter.category_type{

            case .buffet_ticket:
                getBuffetTickets()

            default:
                if let buffet = order.buffet, APIParameter.buffet_ticket_id != nil  {
                    self.getDetailOfBuffetTicket(buffet: buffet)
                }else{
                    self.getFoods()
                }

        }
    }
    

    init() {
        // Observe changes to the search query and trigger the API request
        $APIParameter
        .map{$0.key_word}
        .debounce(for: .milliseconds(200), scheduler: RunLoop.main) // Delay API call until user stops typing
        .removeDuplicates()
        .sink {[weak self]keyWord in
            guard let self = self else { return }
            
            reloadContent()
        
        }.store(in: &cancellables)
        
        
        self.$foods.sink{ list in
            
            //========================  save selected item ============
            for (_,selectedItem) in list.filter{$0.isSelect}.enumerated(){
                if let p = self.selectedFoods.firstIndex(where:{$0.id == selectedItem.id}){
                    self.selectedFoods[p] = selectedItem
                }else{
                    self.selectedFoods.append(selectedItem)
                }
            }
            

        }.store(in: &cancellables)
         
        
        self.$buffets.sink{[weak self] list in
            
            guard let self = self else { return }

            
            if let item = list.filter({ $0.isSelect }).first {
                self.selectedBuffet = item
            }
            

        }.store(in: &cancellables)

        
        
    }
    deinit{
        
    }
  
    

}
extension FoodViewModel{
    
    func getCategories(){
        
        NetworkManager.callAPI(netWorkManger: .categories(
            brand_id: Constants.brand.id ?? 0,
            status: ACTIVE,
            type:  APIParameter.category_type == .all ? 0 : APIParameter.category_type.rawValue)
        ){[weak self] result in
            guard let self = self else { return }
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[Category]>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
                    var list = res.data
                   
                    var cate = Category()
                    cate.id = -1
                    cate.name = "Tất cả"
                    cate.isSelect = true
                    
                    list.insert(cate, at: 0)
                    dLog(list)
                    self.categories = list
                    
                    self.APIParameter.category_id = cate.id
                    
                    self.reloadContent()
            

                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    
    
    func getFoods(){
        NetworkManager.callAPI(netWorkManger:.foods(
            branch_id: Constants.branch.id ?? 0,
            area_id: PermissionUtils.GPBH_1 ? -1 : order.area_id,
            category_id: APIParameter.category_id,
            category_type: APIParameter.category_type.rawValue,
            is_allow_employee_gift: APIParameter.is_allow_employee_gift,
            is_sell_by_weight: APIParameter.is_sell_by_weight,
            is_out_stock: APIParameter.is_out_stock,
            key_word: APIParameter.key_word,
            limit: APIParameter.limit,
            page:APIParameter.page
        )){[weak self] result in
            guard let self = self else { return }
            
            switch result {
                  case .success(let data):
                
                    guard var res = try? JSONDecoder().decode(APIResponse<FoodResponse>.self, from: data) else{
                        dLog("parse model sai rồi")
                        return
                    }
                  
                
                  
                    self.APIParameter.total_record = res.data.total_record
                    
                    
                    for (i,element) in res.data.list.enumerated(){
                        if let selectedItem = self.selectedFoods.first(where: {$0.id == element.id}){
                            res.data.list[i] = selectedItem
                        }
                    }
                    self.foods.append(contentsOf: res.data.list)
                    
                  case .failure(let error):
                    dLog(error)
            }
        }
    }
    

}
