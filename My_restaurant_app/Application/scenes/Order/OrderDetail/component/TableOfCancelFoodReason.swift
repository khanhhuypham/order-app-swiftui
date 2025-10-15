//
//  TableOfCancelFoodReason.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 19/09/2024.
//

import SwiftUI

struct TableOfCancelReasonView: View {

    var completion:((String) -> Void)? = nil

    var body: some View {
        PopupWrapper(){
            TableOfCancelReasoncontent(completion: completion)
        }
    }
}

private struct TableOfCancelReasoncontent: View {
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) var color: ColorPalette
    @Environment(\.dismiss) var dismiss
//    @State var shouldPerformCompletion = false
    @State var item:OrderItem? = nil

    @State var list:[CancelReason] = []
    var completion:((String) -> Void)? = nil
    
    var body: some View {
        VStack(spacing:0) {
            
            Text("LÝ DO HUỶ MÓN")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(color.orange_brand_900)
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
                    dismiss()
                } label: {
                    Text("HUỶ")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(color.red_600)
                        .background(color.gray_200)
                }
                .buttonStyle(.plain)
                
                Button {
     
                    if let reason = list.first(where: {$0.is_select}){
                        completion?(reason.content)
                    }
                    
                    dismiss()
                } label: {
                    Text("ĐỒNG Ý")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(color.orange_brand_900)
            
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
//        .onDisappear(perform: {
//            if shouldPerformCompletion{
//                completion?()
//            }
//        })
  
    }
    
    
    private func getReasonOfCancel(){

        NetworkManager.callAPI(netWorkManger: .reasonCancelFoods(branch_id: Constants.branch.id ?? 0)){ (result: Result<APIResponse<[CancelReason]>, Error>) in
           
            switch result {

                case .success(let res):
                    if res.status == .ok{
                        list = res.data
                    }
                        
                
                case .failure(let error):
                   dLog("Error: \(error)")
            }
        }
        
        
    }
    
 
    
    
}






