import Foundation

protocol OrderLogRepository {
    func fetchOrderLogs(orderId: Int) async -> Result<[ActivityLog], Error>
}

struct GetOrderLogUseCase {
    private let repository: OrderLogRepository
    
    init(repository: OrderLogRepository) {
        self.repository = repository
    }
    
    func execute(orderId: Int) async -> Result<[ActivityLog], Error> {
        await repository.fetchOrderLogs(orderId: orderId)
    }
}
