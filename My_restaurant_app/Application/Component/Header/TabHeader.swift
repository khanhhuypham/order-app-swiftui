//
//  TabHeader.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 12/10/2024.
//

import SwiftUI

struct TabHeader: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @Binding var tabArray:[(id:Int,title:String,isSelect:Bool)]
    
    var isScrollable = false
    var clickClosure:((Int) -> Void)? = nil
    
    var body: some View {
        
        if isScrollable{
            ScrollView(.horizontal, showsIndicators: false){
                content
            }
        }else{
            content
        }
       
    }
    
    private var content:some View{
        HStack(spacing:16){
            ForEach(Array(tabArray.enumerated()), id: \.offset){i,element in
                
                Button(action: {
                    // Action for Món ăn
                    for (j,_) in tabArray.enumerated(){
                        tabArray[j].isSelect = i == j ? true : false
                    }
                    if let clickClosure = self.clickClosure{
                        clickClosure(element.id)
                    }
                    
                }) {
                    VStack(alignment:.center,spacing:0){
                        
                        Spacer()
                        
                        Text(element.title)
                            .font(font.sb_15)
                            .foregroundColor(element.isSelect ? color.green_600 : color.green_200)
                        
                        
                        Spacer()
                        
                        Rectangle()
                            .padding(.horizontal,-5)
                            .frame(height:5) // Height of the underline
                            .foregroundColor(element.isSelect ? color.green_600 : color.white) // Color of the underline
                            .opacity(0.7) // Adjust opacity if needed
                    }
                }
                .frame(maxWidth:.infinity)
                
            }
        }.frame(maxWidth:.infinity)
    }
}

#Preview {
    
    ZStack{
       
       Rectangle()
       
        TabHeader(tabArray:.constant([
            (id:0,title:"DANH MỤC",isSelect:false),
            (id:1,title:"MÓN ĂN",isSelect:false),
            (id:2,title:"GHI CHÚ",isSelect:false),
        ]))
        .frame(height:50)
        .frame(maxWidth:.infinity)
        .background(.white)
        
       
   }
}
