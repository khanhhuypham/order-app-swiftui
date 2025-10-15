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
    @State var order:Order = Order()
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
    
//    if permissionUtils.OrderManager {
//        view_of_order_history.isHidden = false
//        view_of_move_table.isHidden = false
//        view_of_merge_table.isHidden = false
//        view_of_split_food.isHidden = false
//        view_of_share_point.isHidden = false
//        view_of_cancel_table.isHidden = false
//        
//      
//        
//        if order?.table_id == 0{
//            view_of_move_table.isHidden = true
//            view_of_merge_table.isHidden = true
//            view_of_share_point.isHidden = true
//            view_of_cancel_table.isHidden = true
//        }
//        
//    }else{
//        view_of_order_history.isHidden = false
//        view_of_move_table.isHidden = true
//        view_of_merge_table.isHidden = true
//        view_of_split_food.isHidden = true
//        view_of_share_point.isHidden = true
//        view_of_cancel_table.isHidden = true
//    }
    
    

    private var content:some View{
        VStack (spacing:20){
            
            VStack (alignment: .leading, spacing: 0){
                if PermissionUtils.OrderManager{
                    
                    ActionSheetCardItem(
                        image:Image("icon-clock", bundle: .main),
                        text:Text("Lịch sử đơn háng").font(font.sb_14)
                    ){
                        action = OrderAction.orderHistory
                        dismiss()
                    }
                    
                    if order.order_method != .TAKE_AWAY{
                        
                        Divider()
                        ActionSheetCardItem(
                            image:Image("icon-move", bundle: .main),
                            text:Text("Chuyển bàn").font(font.sb_14)
                        ){
                            action = OrderAction.moveTable
                            dismiss()
                        }
                    }
                    
                    
                    
                    if order.order_method != .TAKE_AWAY{
                        Divider()
                        
                        ActionSheetCardItem(
                            image:Image("icon-merge", bundle: .main),
                            text:Text("Gộp bàn").font(font.sb_14)
                        ){

                            action = OrderAction.mergeTable
                            dismiss()
                        }
                        
                    }
                    
                    if order.order_method != .TAKE_AWAY{
                        Divider()
                        
                        ActionSheetCardItem(
                            image:Image("icon-split", bundle: .main),
                            text:Text("Tách món").font(font.sb_14)
                        ){
                           
                            action = OrderAction.splitFood
                            dismiss()
                        }
                        
                    }
               
                    
                    if order.order_method != .TAKE_AWAY{
                        Divider()
                        ActionSheetCardItem(
                            image:Image("icon-share", bundle: .main),
                            text:Text("Chia điểm").font(font.sb_14)
                        ){
                            action = OrderAction.sharePoint
                            dismiss()
                        }
                        
                    }
                    
                 
                 
                    Divider()
               
                    ActionSheetCardItem(
                        image:Image(systemName: "xmark"),
                        text:Text("Huỷ Bàn").font(font.sb_14)
                    ){
                        
                        action = OrderAction.cancelOrder
                        dismiss()
                    }
                }else{
                    
                    
                    
                    ActionSheetCardItem(
                        image:Image("icon-clock", bundle: .main),
                        text:Text("Lịch sử đơn háng").font(font.sb_14)
                    ){
                        action = OrderAction.orderHistory
                        dismiss()
                    }
                    
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
