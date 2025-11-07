//
//  OrderLogViewModel.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//

import SwiftUI

// MARK: - Presentation Layer
@MainActor
final class OrderLogViewModel: ObservableObject {
    
    private let getOrderLogUseCase: GetOrderLogUseCase
    
    @Published var dataArray: [ActivityLog] = []
    @Published var searchKey = ""
    
    init(getOrderLogUseCase: GetOrderLogUseCase) {
        self.getOrderLogUseCase = getOrderLogUseCase
    }
    
    func getOrderLog(orderId: Int) async {
        let result = await getOrderLogUseCase.execute(orderId: orderId)
        switch result {
            case .success(let logs):
                dataArray = logs
            
            case .failure(let error):
                dLog("Error: \(error)")
        }
    }
    
}
