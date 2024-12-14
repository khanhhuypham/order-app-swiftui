//
//  ToastPopup.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 25/09/2024.
//

import SwiftUI
import AlertToast
struct ToastPopup: View {
    @State var show = false
    @State var alertToast = AlertToast(type: .regular, title: "SOME TITLE"){
        didSet{
            show.toggle()
        }
    }
    
    
    var body: some View {
        VStack (spacing:20){
            Button("Show Loading"){
                alertToast = AlertToast(type: .loading)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    show = false
                })
            }
            
             //Presenting alert from ObservableObject
            Button("Toast error"){
                alertToast = AlertToast(type: .error(.red), title:"Success", subTitle: "Load dữ liệu thành công")
            }
            Button("Toast System Image"){
                alertToast = AlertToast(type: .systemImage("wifi.router", .red), title: "Warning", subTitle: "Wifi yếu")
            }
            

            Button("Toast alert regular message"){
                alertToast = AlertToast(type: .regular, title: "warning", subTitle: "Phạm Khánh Huy")
            }
            
        
            Button("complete Alert"){
                alertToast = AlertToast(displayMode:.alert,type: .complete(.green), title:"Success", subTitle: "Load dữ liệu thành công")
            }
            
            Button("Complete - hud display"){
                alertToast = AlertToast(displayMode: .hud, type: .complete(.green), title:"Success", subTitle: "Load dữ liệu thành công")
            }
            
            //You can also change the alert type, present
            //a different one and show (because of didSet)
            Button("Complete - pop banner display"){
                alertToast = AlertToast(displayMode: .banner(.pop), type: .complete(.green), title:"Success", subTitle: "Load dữ liệu thành công")
            }
            
            Button("Complete - slide banner display"){
                alertToast = AlertToast(displayMode: .banner(.slide), type: .complete(.green), title:"Success", subTitle: "Load dữ liệu thành công")
            }
        }.toast(isPresenting:$show,duration: 1){
            alertToast
        }
    }
}

#Preview {
    ToastPopup()
}
