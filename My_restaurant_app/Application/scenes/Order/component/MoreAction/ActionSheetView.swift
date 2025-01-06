//
//  MoreActionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 09/09/2024.
//

import SwiftUI

struct BottomSheet: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Environment(\.dismiss) var dismiss
    @State private var performCompletion = true
    @State private var action:OrderAction = .orderHistory
    
    var btnClosure:((OrderAction?) -> Void)? = nil
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                    performCompletion = false
                }
            
            content
                .padding(.bottom, 20)
                .transition(.move(edge: .bottom))
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: true)
        .background(BackgroundClearView())
        .onDisappear(perform: {
            if performCompletion{
                btnClosure?(action)
            }
        })

    }
    

    private var content:some View{
        VStack (spacing:20){
            
            VStack (alignment: .leading, spacing: 0){
                
                ActionSheetCardItem(
                    image:Image("icon-clock", bundle: .main),
                    text:Text("Lịch sử đơn háng")
                        .font(font.r_14)
                ){
                    action = OrderAction.orderHistory
                    dismiss()
                }
                Divider()
                ActionSheetCardItem(
                    image:Image("icon-move", bundle: .main),
                    text:Text("Chuyển bàn").font(font.r_14)
                ){
                    action = OrderAction.moveTable
                    dismiss()
                }
                
                Divider()
                
                ActionSheetCardItem(
                    image:Image("icon-merge", bundle: .main),
                    text:Text("Gộp bàn").font(font.r_14)
                ){

                    action = OrderAction.mergeTable
                    dismiss()
                }
                
                Divider()
                
                ActionSheetCardItem(
                    image:Image("icon-split", bundle: .main),
                    text:Text("Tách món").font(font.r_14)
                ){
                   
                    action = OrderAction.splitFood
                    dismiss()
                }
                
                Divider()
                
                ActionSheetCardItem(
                    image:Image("icon-share", bundle: .main),
                    text:Text("Chia điểm").font(font.r_14)
                ){
                    action = OrderAction.sharePoint
                    dismiss()
                }
                
                Divider()
           
                ActionSheetCardItem(
                    image:Image(systemName: "xmark"),
                    text:Text("Huỷ Bàn").font(font.r_14)
                ){
                    
                    action = OrderAction.cancelOrder
                    dismiss()
                }
            
            }
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(8)
            
            Button {
                dismiss()
                performCompletion = false
            } label: {
                Text("Huỷ")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
//                    .padding(.top,30)
            }
            
           
        }
      
    }
        
    
}





//struct ActionSheetView: View {
//    
//    @State var isShowingBottomSheet = false
//    
//    var body: some View {
//        ZStack{
//            Button{
//                withAnimation{
//                    isShowingBottomSheet.toggle()
//                }
//            } label: {
//                Text("more action")
//            }
//            BottomSheet(isShowing: $isShowingBottomSheet)
//        }
//    }
//    
//}
//
//#Preview(body: {
//    ActionSheetView()
//})
