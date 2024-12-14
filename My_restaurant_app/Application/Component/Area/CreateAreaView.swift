//
//  UpdateAreaView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 17/10/2024.
//

import SwiftUI



import SwiftUI
import Combine
struct CreateAreaView: View {
    var delegate:EnterPercentDelegate?
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color


    @Binding var isPresent:Bool
    @State var area:Area = Area()
    var valid: Bool {
        (area.name.count >= 2 && area.name.count <= 20)
    }
    var onConfirmPress: ((Area) -> Void)? = nil

    var body: some View {
        
        VStack{
            Spacer()
            mainContent
            Spacer()
        }
        
    }
    
    private var mainContent:some View{
        VStack(spacing:0) {
            
            Text(String(format: "%@", area.id == 0 ? "thêm khu vực" : "cập nhật khu vực").uppercased())
                .font(font.b_18)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            
            VStack(alignment:.leading,spacing: 15){
                
                TextField("Tên khu vực", text: $area.name)
                    .font(font.r_13)
                    .frame(height: 38)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 6))
                    .overlay(
                      // Placeholder and border overlay
                      RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(uiColor: .systemGray3), lineWidth: 1) // Border
                    )
                    .background(color.gray_200)
                
                
                if area.id > 0{
                    
                    Button(action: {
                        area.status = area.status == ACTIVE ? DEACTIVE : ACTIVE
                    }) {
                        HStack{
                            Image(area.status == ACTIVE ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                            Text("ĐANG HOẠT ĐỘNG")
                                .font(font.r_14)
                                .foregroundColor(.black)
                            
                        }.frame(maxWidth:.infinity,alignment: .leading)
                        
                    }
                }
            }
            .padding(.vertical,20).padding(.horizontal,20)

       
            HStack(spacing:0){
                Button {
                    isPresent = false
                } label: {
                    Text("HUỶ")
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(color.red_600)
                        .background(color.gray_200)
                }.buttonStyle(.plain)
                
                Button {
                  
                    
                    if let confirm = self.onConfirmPress,valid{
                        if area.id == 0{
                            area.status = ACTIVE
                        }
                       
                        confirm(area)
                        isPresent = false
                    }
                    
                } label: {
                    Text(String(format: "%@", area.id == 0 ? "thêm mới" : "cập nhật").uppercased())
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(valid ? color.orange_brand_900 : color.gray_600)
                        .disabled(valid)
            
                }
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(10)
        .padding(.horizontal, 40)
        .onAppear(perform: {
            
        })
    }
    
}



#Preview {
    ZStack {
        Rectangle()
        CreateAreaView(isPresent:.constant(true))
    }
   
}
