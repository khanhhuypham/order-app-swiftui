//
//  MoreActionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 09/09/2024.
//

import SwiftUI

struct BottomSheet: View {

    @Binding var isShowing: Bool
    
   
    var body: some View {
        
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                content
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom))
                    .cornerRadius(16)
                    .padding(.horizontal, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
    

    private var content:some View{
        VStack (spacing:20){
            
            VStack (alignment: .leading, spacing: 0){
                
                ActionSheetCardItem(
                    image:Image("icon-clock", bundle: .main),
                    text:Text("Lịch sử đơn háng").font(.headline)
                ){
                    
                }
                
                ActionSheetCardItem(
                    image:Image("icon-move", bundle: .main),
                    text:Text("Chuyển bàn").font(.headline)) {
                    //
                }
                
                Divider()
                
                ActionSheetCardItem(
                    image:Image("icon-merge", bundle: .main),
                    text:Text("Gộp bàn").font(.headline)) {
                    //
                }
                
                Divider()
                
                ActionSheetCardItem(
                    image:Image("icon-split", bundle: .main),
                    text:Text("Tách món").font(.headline)){
                    
                }
                
                Divider()
                
                ActionSheetCardItem(
                    image:Image("icon-share", bundle: .main),
                    text:Text("Chia điểm").font(.headline)){
                    
                }
                
                Divider()
           
                ActionSheetCardItem(
                    image:Image(systemName: "xmark"),
                    text:Text("Huỷ món").font(.headline)){
                    
                }
            
            }
            .background(Color.white)
            .cornerRadius(10)
            
            Button {
                isShowing = false
            } label: {
                Text("Huỷ")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.orange)
                    .cornerRadius(10)
//                    .padding(.top,30)
            }
            
           
        }
        .background(Color.clear) // Transparent background
      

    }
        
    
}





struct ActionSheetView: View {
    
    @State var isShowingBottomSheet = false
    
    var body: some View {
        ZStack{
            Button{
                withAnimation{
                    isShowingBottomSheet.toggle()
                }
            } label: {
                Text("more action")
            }
            
            BottomSheet(isShowing: $isShowingBottomSheet)
        }
    }
    
}

#Preview(body: {
    ActionSheetView()
})
