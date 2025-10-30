//
//  FoodViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 21/09/2024.
//

import SwiftUI
import Combine

class FoodViewModel: ObservableObject {
    let service: FoodServiceProtocol
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
    
    @Published public var presentFullScreen:(
        show:Bool,
        popupType:PopupType,
        item:Food?
    ) = (false,.cancel,nil)
    
    @Published public var presentSheet:(present:Bool,item:Food?) = (false,nil)

    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - PAGINATION
    func loadMoreContent(currentItem item: Food){

        if self.foods.endIndex < APIParameter.total_record {
            APIParameter.page += 1
            Task{
                await getFoods()
            }
        }
        
    }
    
    //MARK: - PAGINATION
    func reloadContent() async{
        APIParameter.page = 1
        foods.removeAll()
        buffets.removeAll()
        switch APIParameter.category_type{

            case .buffet_ticket:
                await getBuffetTickets()

            default:
                if let buffet = order.buffet, APIParameter.buffet_ticket_id != nil  {
                    await self.getDetailOfBuffetTicket(buffet: buffet)
                }else{
                    await self.getFoods()
                }

        }
    }
    

    init(service:FoodServiceProtocol = FoodService()) {
        self.service = service
        
        // Observe changes to the search query and trigger the API request
        $APIParameter
        .map{$0.key_word}
        .debounce(for: .milliseconds(200), scheduler: RunLoop.main) // Delay API call until user stops typing
        .removeDuplicates()
        .sink {[weak self]keyWord in
            guard let self = self else { return }
//            reloadContent()
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
    
    @MainActor
    func getCategories()async{
        
        let result = await service.getCategories(
            branchId: Constants.brand.id,
            status: ACTIVE,
            categoryType: APIParameter.category_type == .all ? "" : APIParameter.category_type.rawValue.description
        )
        
        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                   
                    var cate = Category()
                    cate.id = -1
                    cate.name = "Tất cả"
                    cate.isSelect = true
                    
                    data.insert(cate, at: 0)
                
                    self.categories = data
                    
                    self.APIParameter.category_id = cate.id
                    
                    await self.reloadContent()
                }
                
             

            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    @MainActor
    func getFoods() async{
        
        let result = await service.getFoods(
            branchId: Constants.branch.id,
            areaId: PermissionUtils.GPBH_1 ? -1 : order.area_id,
            categoryId: APIParameter.category_id,
            categoryType: APIParameter.category_type.rawValue,
            is_allow_employee_gift: APIParameter.is_allow_employee_gift,
            is_sell_by_weight: APIParameter.is_sell_by_weight,
            is_out_stock: APIParameter.is_out_stock,
            key_word: APIParameter.key_word,
            limit: APIParameter.limit,
            page:APIParameter.page
        )

        switch result {

            case .success(let res):
            
                if res.status == .ok,var data = res.data{
                    
                    self.APIParameter.total_record = data.total_record
                    
                    for (i,element) in data.list.enumerated(){
                        if let selectedItem = self.selectedFoods.first(where: {$0.id == element.id}){
                            data.list[i] = selectedItem
                        }
                    }
                
                    self.foods.append(contentsOf: data.list)
                }
               
            case .failure(let error):
               dLog("Error: \(error)")
        }
        
        
    }
    

}
