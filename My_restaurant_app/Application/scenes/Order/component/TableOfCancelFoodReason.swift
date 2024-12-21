//
//  TableOfCancelFoodReason.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 19/09/2024.
//

import SwiftUI
import PopupView

struct TableOfCancelReasonView: View {
    @Binding var isPresent:Bool
    var id = 0
    @State var inputText = ""
   
    var body: some View {
        PopupWrapper(isPresented: $isPresent){
            TableOfCancelReasoncontent(isPresent: $isPresent)
        }
    }
}

private struct TableOfCancelReasoncontent: View {
    @Binding var isPresent:Bool
    var delegate:ReasonCancelItemDelegate?
    @State var item:OrderItem? = nil
//    @Environment(\.popupDismiss) var dismiss
    @Injected(\.fonts) private var fonts
    @State var list:[CancelReason] = []
    
    var body: some View {
        VStack(spacing:0) {
            
            Text("LÝ DO HUỶ MÓN")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(ColorUtils.orange_brand_900()))
                .padding(.top,20)
                .padding(.bottom,30)
            
            List {
                ForEach(Array(list.enumerated()), id: \.1) { i,element in
                    HStack{
                        Image(element.is_select ? "icon-radio-check" : "icon-radio-uncheck", bundle: .main)
                        
                        Text(element.content)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.vertical,5)
                    .padding(.trailing,5)
                    .background(.white)
                    
                    .onTapGesture(perform: {
                        list.enumerated().forEach { (index, value) in
                            list[index].is_select = element.id == value.id
                            self.item?.cancel_reason = element.content
                            
                        }
                    })
                 
                }
                .buttonStyle(PlainButtonStyle())

            }
            .listStyle(.plain)
            .frame(height: 290)
            .padding(.bottom,30)

            
        
            HStack(spacing:0){
                Button {
//                    dismiss?()
                    isPresent = false
                } label: {
                    Text("HUỶ")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(Color(ColorUtils.red_600()))
                        .background(Color(ColorUtils.gray_200()))
                }.buttonStyle(.plain)
                
                Button {
                    guard let item = self.item else {return }
                    delegate?.cancel(item: item)
                    isPresent = false
                } label: {
                    Text("ĐỒNG Ý")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(Color(ColorUtils.orange_brand_900()))
            
                }
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(10)
        .padding(.horizontal, 40)
        .onAppear(perform: {
            self.getReasonOfCancel()
        })
  
    }
    
    
    private func getReasonOfCancel(){
        
        NetworkManager.callAPI(netWorkManger: .reasonCancelFoods(branch_id: Constants.branch.id ?? 0)){result in
          
            switch result {
                  case .success(let data):
                        
                    guard let res = try? JSONDecoder().decode(APIResponse<[CancelReason]>.self, from: data) else{
                        return
                    }
                    print(res.data.count)
                    list = res.data
                
                  case .failure(let error):
                      print(error)
            }
        }
    }
    
 
    
    
}


#Preview {
    
//    let list = CancelReason.getDummyData()
//    if  !list.isEmpty {
//        return ZStack {
//            Rectangle()
//                .ignoresSafeArea()
//            PopupMiddle(list:list)
//        }
//    }
//    
    return EmptyView()
    
   

}




