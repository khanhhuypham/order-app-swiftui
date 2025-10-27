//
//  OrderListViewModel.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//


extension OrderListViewModel {
    

    @MainActor
    func getOrders(page:Int) async {
        
        guard !APIParameter.isAPICalling else { return }
        guard !APIParameter.isGetFullData else { return }
        APIParameter.isAPICalling = true
        defer { APIParameter.isAPICalling = false } // ✅ always reset
        
        let result = await service.fetchOrders(
           brandId: Constants.brand.id,
           branchId: Constants.branch.id,
           userId: 0,
           orderMethods: APIParameter.order_methods.map { $0.rawValue.description }.joined(separator: ","),
           orderStatus: APIParameter.order_status,
           limit: APIParameter.limit,
           page:APIParameter.page
        )

        switch result {
           case .success(let res):
               if res.status == .ok, let data = res.data {

                   guard data.list.isEmpty == false else {
                       APIParameter.isGetFullData = true
                       return
                   }
               
                   orderList.append(contentsOf: data.list)
                   APIParameter.page = page
                   APIParameter.isGetFullData = data.list.count < APIParameter.limit
                  
                  
                }
           case .failure(let error):
                print("❌ Orders API failed: \(error)")
        }
        
   }


    
    @MainActor
    func closeTable(id: Int) async {
        let result = await service.closeTable(orderId: id)
        
        switch result {
            case .success(let res):
                if res.status == .ok {
//                    toast.show("Huỷ bàn thành công")
                } else {
//                    toast.show(res.message)
                }
            case .failure(let error):
                print("❌ Close table failed: \(error.localizedDescription)")
        }
    }
}
