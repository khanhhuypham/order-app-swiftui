//
//  OrderListViewModel + extension + socket.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 27/9/25.
//


extension OrderDetailViewModel {


    func setupSocketIO(){
        // socket io here
        let namespace = String(format:"/restaurants_%d_branches_%d", Constants.brand.id, Constants.branch.id)
        let real_time_url = String(format: "restaurants/%d/branches/%d/orders/%d", Constants.restaurant_id, Constants.branch.id,order.id)
        socketManager.initOrderRealTimeSocketInstance(namespace)
        
        socketManager.orderRealTimeSocket.on("connect") {data, ack in
              dLog("connected==============: \(data.description)")
              dLog("connected==============: \(data.description)")
        }
        socketManager.orderRealTimeSocket.connect()
        
        socketManager.orderRealTimeSocket.on("connect") {data, ack in
            
            self.socketManager.orderRealTimeSocket.emit("join_room", real_time_url)
            
            self.socketManager.orderRealTimeSocket.on(real_time_url) {data, ack in

                Task{
                    await self.getOrder()
                }
            }
        }
        
    }
    
    func socketIOLeaveRoom(){
        let real_time_url = String(format: "restaurants/%d/branches/%d/orders/%d",Constants.restaurant_id, Constants.branch.id,order.id)
        socketManager.orderRealTimeSocket.emit("leave_room", real_time_url)
    }
  

}
