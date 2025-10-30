//
//  OrderService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//



final class OrderDetailService: OrderDetailServiceProtocol {


    
    func getOrder(orderId: Int, branchId: Int) async -> Result<APIResponse<OrderDetail>, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .order(order_id: orderId, branch_id: branchId))
    }
    
    func getBookingOrder(orderId: Int) async -> Result<APIResponse<[PrintItem]>, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .getFoodsBookingStatus(order_id: orderId))
    }


    func getFoodsNeedPrint(orderId: Int) async -> Result<APIResponse<[PrintItem]>, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .foodsNeedPrint(order_id: orderId))
    }
    
    func updateAlreadyPrinted(orderId:Int, order_detail_ids: [Int]) async -> Result<PlainAPIResponse, any Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .updateAlreadyPrinted(order_id: orderId, order_detail_ids: order_detail_ids))
    }
    
    func sendRequestPrintOrderItem(branchId: Int, orderId: Int, printType: Int) async -> Result<PlainAPIResponse, any Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .sendRequestPrintOrderItem(order_id: orderId, branch_id: branchId, print_type: printType))
    }
    
    
    
  
    func cancelItem(branchId: Int, orderId: Int, reason: String, orderDetailId: Int, quantity: Int) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .cancelFood(branch_id: branchId, order_id: orderId, reason: reason, order_detail_id: orderDetailId, quantity: quantity))
    }

    func discountOrderItem(branchId: Int, orderId: Int, orderItem: OrderItem) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .postDiscountOrderItem(branch_id: branchId, orderId: orderId, orderItem: orderItem))
    }

    func addNote(branchId: Int, orderDetailId: Int, note: String) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .addNoteToOrder(branch_id: branchId, order_detail_id: orderDetailId, note: note))
    }

    func updateItems(branchId: Int, orderId: Int, orderItems: [OrderItemUpdate]) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .updateFoods(branch_id: branchId, order_id: orderId, orderItemUpdate: orderItems))
    }
}
