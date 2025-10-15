import SocketIO

class SocketIOManager: ObservableObject {
    static let shared = SocketIOManager()
    
    private var orderRealTimeManager: SocketManager
    var orderRealTimeSocket: SocketIOClient
    
    init() {
        // Replace with your server URL
        orderRealTimeManager = SocketManager(socketURL: URL(string: "http://localhost:3000")!,config: [.log(true), .compress])
        orderRealTimeSocket = orderRealTimeManager.socket(forNamespace: "/chat") // 👈 use namespace here
//        socket = manager.defaultSocket
        
        addHandlers()
        orderRealTimeSocket.connect()
    }
    
    func initOrderRealTimeSocketInstance(_ namespace: String) {

        if let url = URL(string: environmentMode.realTimeUrl),let token = Constants.user.access_token{
            let auth = ["token": String(format: "Bearer %@", token)]
            let cofig:SocketIOClientConfiguration = [
                .log(true),
                .compress,
                .reconnects(true),
                .extraHeaders(auth),
                .forceWebsockets(true),
            ]
            
            self.orderRealTimeManager = SocketManager(socketURL: url, config: cofig)
            self.orderRealTimeSocket =  self.orderRealTimeManager.socket(forNamespace: namespace)
            self.orderRealTimeManager.connectSocket(self.orderRealTimeSocket, withPayload: auth)
            self.orderRealTimeSocket.connect()
        }
        
    }
    
    private func addHandlers() {
        orderRealTimeSocket.on(clientEvent: .connect) { data, ack in
            print("✅ Connected to server")
        }
        
        orderRealTimeSocket.on("message") { data, ack in
            print("📩 Received message:", data)
        }
    }
    
    func sendMessage(_ msg: String) {
        orderRealTimeSocket.emit("message", msg)
    }
}
