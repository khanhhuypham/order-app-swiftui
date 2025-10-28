//
//  OrderDetailServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 28/10/25.
//


protocol OrderDetailServiceProtocol {
    
    func getOrder(orderId: Int, branchId: Int) async -> Result<APIResponse<OrderDetail>, Error>
    func getFoodsNeedPrint(orderId: Int) async -> Result<APIResponse<[PrintItem]>, Error>
    func getBookingOrder(orderId: Int) async -> Result<APIResponse<[PrintItem]>, Error>
    func cancelItem(branchId: Int, orderId: Int, reason: String, orderDetailId: Int, quantity: Int) async -> Result<PlainAPIResponse, Error>
    func discountOrderItem(branchId: Int, orderId: Int, orderItem: OrderItem) async -> Result<PlainAPIResponse, Error>
    func addNote(branchId: Int, orderDetailId: Int, note: String) async -> Result<PlainAPIResponse, Error>
    func updateItems(branchId: Int, orderId: Int, orderItems: [OrderItemUpdate]) async -> Result<PlainAPIResponse, Error>
}

/*
 MARK: SOLID PRINCIPLE
 
 MARK: S — Single Responsibility Principle
    || A class or module should have one reason to change.
 
    All of methods:
         • getOrder
         • discountOrderItem
         • addNote
         • cancelItem
         • updateItems
         • getFoodsNeedPrint
         • getBookingOrder

    are about managing the details of a single order — so they all belong to the same business reason to change (the OrderDetail API contract). ✅
 
 👉 That means class OrderDetailViewModel still has a single responsibility: “Provide all network operations for order detail management.”
 
 MARK: O — Open/Closed Principle
    || Software entities should be open for extension, closed for modification.
    Software entities should be open for extension, closed for modification.
    If we add a new endpoint later (like splitOrderItem), we can just add a new method to our protocol — and the rest of our module continues working without breaking.
    ✅ Still good.
 
 MARK: L — Liskov Substitution Principle
 
 You can easily swap OrderDetailService with a mock in tests.
 No problem here. ✅
 
 MARK: I — Interface Segregation Principle
  || Clients should not be forced to depend upon methods they do not use.
 
 
 MARK: D — Dependency Inversion Principle
 
 Your ViewModel depends on an abstraction, not a concrete service. ✅
 You’ve done this perfectly:
 
 
 */

