import SwiftUI
import Combine

struct FoodAPIParameter: Equatable {
    var categoryId: Int = -1
    var categoryType: FOOD_CATEGORY = .all
    var isAllowEmployeeGift: Int = -1
    var isSellByWeight: Int = ALL
    var isOutStock: Int = -1
    var isUsePoint: Int = 0
    var keyWord: String = ""
    var limit: Int = 50
    var page: Int = 1
    var totalRecord: Int = 0
    var buffetTicketId: Int? = nil
}


@MainActor
final class FoodViewModel: ObservableObject {
    private let useCase: FoodUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Published Properties
    @Published var navigateTag: Int? = -1
    @Published var order: OrderDetail = OrderDetail()
    @Published var categories: [Category] = []
    @Published var foods: [Food] = []
    @Published var buffets: [Buffet] = []
    
    var selectedFoods: [Food] = []
    var selectedBuffet: Buffet? = nil
    
    @Published var APIParameter: FoodAPIParameter = FoodAPIParameter()
    @Published var isLoading = false
    @Published var presentFullScreen: (show: Bool, popupType: PopupType, item: Food?) = (false, .cancel, nil)
    @Published var presentSheet: (present: Bool, item: Food?) = (false, nil)
    
    // MARK: - Init
    init() {
        
        self.useCase = FoodUseCase(
            foodProviderLocalRepo:FoodLocalRepo(),
            foodProviderRemoteRepo: FoodRemoteRepo(),
            foodServiceRepo:FoodRemoteRepo()
        )
        
        setupBindings()
    }
    
    private func setupBindings() {
        $APIParameter
            .map { $0.keyWord }
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .dropFirst() // 👈 Ignore the initial emission
            .sink { [weak self] _ in
                Task {
                    await self?.reloadContent()
                }
            }
            .store(in: &cancellables)
        
        $foods
            .sink { [weak self] list in
                guard let self = self else { return }
                for item in list.filter({ $0.isSelect }) {
                    if let index = self.selectedFoods.firstIndex(where: { $0.id == item.id }) {
                        self.selectedFoods[index] = item
                    } else {
                        self.selectedFoods.append(item)
                    }
                }
            }
            .store(in: &cancellables)
        
        $buffets
            .sink { [weak self] list in
                self?.selectedBuffet = list.first(where: { $0.isSelect })
            }
            .store(in: &cancellables)
    }
    
    //MARK: - PAGINATION
    func loadMoreContent(currentItem item: Food){

        if self.foods.endIndex < APIParameter.totalRecord {
            APIParameter.page += 1
            Task{
                await getFoods()
            }
        }
        
    }
    
    
    // MARK: - Pagination
    func reloadContent() async{
        APIParameter.page = 1
        foods.removeAll()
        buffets.removeAll()
        switch APIParameter.categoryType{

            case .buffet_ticket:
                await getBuffetTickets()

            default:
                if let buffet = order.buffet, APIParameter.buffetTicketId != nil  {
                    await self.getDetailOfBuffetTicket(buffet: buffet)
                }else{
                    await self.getFoods()
                }

        }
    }
    
    
    
    func getCategories() async {
        
        let result = await useCase.getCategories(
            branchId: Constants.brand.id,
            status: ACTIVE,
            categoryType: APIParameter.categoryType == .all ? "" : APIParameter.categoryType.rawValue.description
        )
        
        
        switch result {
             case .success(let data):
                 // data might be nil if server returned empty
                 var categories: [Category] = data ?? []

                 // Insert "All" category at the top
                 let allCategory = Category(id: -1, name: "Tất cả", isSelect: true)
                 categories.insert(allCategory, at: 0)

                 // Update state
                 self.categories = categories
                 self.APIParameter.categoryId = allCategory.id

                 // Reload content
                 await self.reloadContent()

             case .failure(let error):
                 if let error = error {
                     dLog("Error: \(error.localizedDescription)")
                 }
             }
    }
    
    
    func getFoods() async {
        isLoading = true
        defer { isLoading = false }
    
        let result = await useCase.getFoods(
            branchId: Constants.branch.id,
            areaId: PermissionUtils.GPBH_1 ? -1 : order.area_id,
            parameter: APIParameter
        )
        
        switch result {
            case .success(let data):
            
                if var data = data{
                    self.APIParameter.totalRecord = data.total_record
                    
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




extension FoodViewModel {
    func addFoods(items: [FoodRequest]) async {
         let result = await useCase.addFoods(branchId: Constants.branch.id, orderId: order.id, items: items)
        
         switch result {
             case .success(let newOrder):
                 if let newOrder = newOrder {
                     order.id = newOrder.order_id
                     self.navigateTag = 0
                 }

             case .failure(let error):
                 if let error = error {
                     dLog("Error: \(error.localizedDescription)")
                 }
         }
         
    }

     func addGiftFoods(items: [FoodRequest]) async {
        let result = await useCase.addGiftFoods(branchId: Constants.branch.id, orderId: order.id, items: items)
        
        switch result {
            case .success:
                self.navigateTag = 0
            
            case .failure(let error):
                if let error = error {
                    // Real error (e.g., code 400)
                    dLog("Error: \(error.localizedDescription)")
                }
        }
    }

    
    func createDineInOrder() async {
        let result = await useCase.createDineInOrder(tableId: order.table_id)
        
        switch result {
            case .success(let data):
                if let table = data{
                    order = OrderDetail(table: table)
                    processToAddFood()
                    self.navigateTag = 1
                }

            case .failure(let error):
                if let error = error {
                    // Real error (e.g., code 400)
                    dLog("Error: \(error.localizedDescription)")
                }
        }
    }

    

    func createTakeOutOrder() async {
        let result = await useCase.createTakeOutOrder(
            branchId: Constants.branch.id,
            tableId: order.table_id,
            note: ""
        )
        
        switch result {
            case .success:
                break
            
            case .failure(let error):
                dLog("Error: \(error)")
        }
    }
}


extension FoodViewModel {
    func getBuffetTickets() async{
        
        let result:Result<BuffetResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getBuffetTickets(
            brand_id: Constants.brand.id,
            status: ACTIVE,
            key_search:APIParameter.keyWord,
            limit: APIParameter.limit,
            page: APIParameter.page
        ))
        
        switch result {

            case .success(var data):
                for (i,buffet) in data.list.enumerated() {
                    data.list[i].updateTickets()
                }
                
                if let selectedItem = self.selectedBuffet,
                   let p = data.list.firstIndex(where: {$0.id == selectedItem.id}){
                    data.list[p] = selectedItem
                }
                
                self.buffets = data.list
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
    func getDetailOfBuffetTicket(buffet:Buffet) async {
        
        let result:Result<FoodResponse, Error> = try await NetworkManager.callAPIResultAsync(netWorkManger: .getDetailOfBuffetTicket(
            branch_id: Constants.branch.id,
            category_id: APIParameter.categoryId,
            buffet_ticket_id: buffet.buffet_ticket_id ?? 0,
            key_search: APIParameter.keyWord,
            limit: APIParameter.limit,
            page: APIParameter.page
        ))

        switch result {

            case .success(var data):
            
              self.APIParameter.totalRecord = data.total_record
              
            
              for (i,element) in data.list.enumerated(){
                  if let selectedItem = self.selectedFoods.first(where: {$0.id == element.id}){
                      data.list[i] = selectedItem
                  }
              }
              self.foods.append(contentsOf: data.list)
                
            case .failure(let error):
               dLog("Error: \(error)")
        }
    }
    
   
}

