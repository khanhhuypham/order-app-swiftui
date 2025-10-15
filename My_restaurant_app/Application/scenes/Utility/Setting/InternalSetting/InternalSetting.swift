//
//  InternalSetting.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 26/9/25.
//

import SwiftUI



struct InternalSetting: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @StateObject var viewModel = InternalSettingViewModel()
    @State private var showGreeting = true
    var body: some View {
        
        List {
            
            Toggle(isOn: $showGreeting){
                
                Text("Chức năng nhiều phương thức thanh toán").font(font.sb_15)
                
            }.tint(color.orange_brand_900)
            
            Toggle(isOn: $showGreeting){
                
                Text("Order món mang về").font(font.sb_15)
                
            }.tint(color.orange_brand_900)
            
            Toggle(isOn: $showGreeting){
                
                Text("Giữ màn hình luôn sáng").font(font.sb_15)
                
            }.tint(color.orange_brand_900)
            
            Toggle(isOn: $showGreeting){
                VStack(alignment:.leading){
                    Text("Xác nhận đơn khi có tài xế").font(font.sb_15)
                    
                    Text("(Tính năng này được bật thì đơn sẽ xác nhận khi có tài xế)")
                        .font(font.r_12)
                        .foregroundColor(.red)
                }
              
            }.tint(color.orange_brand_900)
          
            
        }
        .listStyle(.plain)
        .defaultListRowStyle()
        .navigationTitle("Thiết lập")
        
    }
   
}

#Preview {
    InternalSetting()
}
