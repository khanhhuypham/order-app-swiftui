import SwiftUI
import Combine

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
    
    @Published var APIParameter: (
        category_id: Int,
        category_type: FOOD_CATEGORY,
        is_allow_employee_gift: Int,
        is_sell_by_weight: Int,
        is_out_stock: Int,
        is_use_point: Int,
        key_word: String,
        limit: Int,
        page: Int,
        total_record: Int,
        buffet_ticket_id: Int?
    ) = (
        category_id: -1,
        category_type: .all,
        is_allow_employee_gift: -1,
        is_sell_by_weight: ALL,
        is_out_stock: -1,
        is_use_point: 0,
        key_word: "",
        limit: 50,
        page: 1,
        total_record: 0,
        buffet_ticket_id: nil
    )
    
    @Published var presentFullScreen: (show: Bool, popupType: PopupType, item: Food?) = (false, .cancel, nil)
    @Published var presentSheet: (present: Bool, item: Food?) = (false, nil)
    
    // MARK: - Init
    init(useCase: FoodUseCase = FoodUseCase(repository: FoodRepository())) {
        self.useCase = useCase
        
        setupBindings()
    }
    
    private func setupBindings() {
        $APIParameter
            .map { $0.key_word }
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task { await self?.reloadContent() }
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
    
    // MARK: - Pagination
    func reloadContent() async {
        APIParameter.page = 1
        foods.removeAll()
        buffets.removeAll()
        
        switch APIParameter.category_type {
        case .buffet_ticket:
//            await getBuffetTickets()
            break
            
        default:
            break
        }
    }
    
    
    func getCategories() async {
        let result = await useCase.getCategories(
            branchId: Constants.brand.id,
            status: ACTIVE,
            categoryType: APIParameter.category_type == .all ? "" : APIParameter.category_type.rawValue.description
        )
        
        switch result {
            case .success(let data):
                dLog(data)
                break
                
            case .failure(let error):
                dLog("Error: \(error)")
        }
    }
    
    
    func getFoods() async {
        let result = await useCase.getFoods(
            branchId: Constants.branch.id,
            areaId: PermissionUtils.GPBH_1 ? -1 : order.area_id,
            categoryId: APIParameter.category_id,
            categoryType: APIParameter.category_type.rawValue,
            is_allow_employee_gift: APIParameter.is_allow_employee_gift,
            is_sell_by_weight: APIParameter.is_sell_by_weight,
            is_out_stock: APIParameter.is_out_stock,
            key_word: APIParameter.key_word,
            limit: APIParameter.limit,
            page: APIParameter.page
        )
        
        switch result {
            case .success(let data):
                break
                
            case .failure(let error):
                dLog("Error: \(error)")
        }
    }
    
    private func addFoods(items: [FoodRequest]) async {
        let result = await useCase.addFoods(branchId: Constants.branch.id, orderId: order.id, items: items)
        
        switch result {
            case .success(let newOrder):
                break
            
            case .failure(let error):
                dLog("Error: \(error)")
        }
    }

    private func addGiftFoods(items: [FoodRequest]) async {
        let result = await useCase.addGiftFoods(branchId: Constants.branch.id, orderId: order.id, items: items)
        
        switch result {
            case .success:
               break
            
            case .failure(let error):
                dLog("Error: \(error)")
        }
    }

    
    func createDineInOrder() async {
        let result = await useCase.createDineInOrder(tableId: order.table_id)
        
        switch result {
            case .success(let table):
                break

            case .failure(let error):
                dLog("Error: \(error)")
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
