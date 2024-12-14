//
//  BuffetOfOrderListCell.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 08/10/2024.
//


import SwiftUI



struct BuffetOfOrderListCell: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    
    @Binding var item:Buffet
    
    var body: some View {
        
        HStack(alignment:.center,spacing: 0){
            HStack(spacing:8){
                LogoImageView(imagePath: "",mold:.square)
                    .frame(width: 40).frame(height: 40)
                
                mainContent
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            .padding(.vertical,15)
           
            
            quantityView.frame(width: 100)
            
        
        }
        .background(.white)
        .onAppear(perform: {
            
         
        })
    
       
    }

    
    private var mainContent: some View {
        VStack(alignment:.leading,spacing: 0){
            
            Text(item.buffet_ticket_name ?? "")
                .font(font.sb_14)
             

            if !item.ticketChildren.isEmpty{
                
                ForEach(Array(item.ticketChildren.enumerated()), id: \.1.id) { (i,value) in
                    VStack(alignment:.leading){
                        HStack(spacing:0){
                            Text(String(format:"+ %@",value.name)).foregroundColor(color.gray_600)
                            Text(String(format:" x %d",value.quantity)).foregroundColor(color.orange_brand_900)
                            Text(" = ").foregroundColor(color.gray_600)
                            if value.discountPercent > 0{
                                Text(value.discountPrice.toString + " ").foregroundColor(color.gray_600)
                                Text(value.totalAmount.toString).foregroundColor(color.gray_600).strikethrough(true)
                            }else{
                                Text(value.totalAmount.toString).foregroundColor(color.gray_600)
                            }
                        }
                        if value.discountPercent > 0{
                            Text(String(format:"   (Giảm giá %0.f%%)",value.discountPercent)).foregroundColor(color.blue_brand_700)
                        }
                        
                    }.font(font.r_11)
                }
        
            }
        
            Text("HOÀN TẤT")
                .font(font.b_12)
                .foregroundColor(color.green_600)
        }
        
        
    }
    

    private var quantityView: some View{
        let totalAmount = (item.total_adult_amount ?? 0) + (item.total_child_amount ?? 0)
        
        return HStack(alignment:.center,spacing:0){
            
            VStack(alignment:.center,spacing: 0){
            

                if item.adult_discount_amount ?? 0 > 0{
                    
                    Text(item.total_final_amount?.toString ?? "")
                        .foregroundColor(color.black)
                    
                    Text(totalAmount.toString )
                        .strikethrough(true)
                        .font(font.r_10)
                        .foregroundColor(color.gray_600)
    
                }else{
                    Text(totalAmount.toString)
                        .foregroundColor(color.gray_600)

                }
                
           
                HStack {
                    Text("Số lượng:").font(font.r_14)
                    Text(((item.adult_quantity ?? 0) + (item.child_quantity ?? 0)).toString).foregroundColor(color.red_600)
                }
               
            }
            .font(font.r_12)
            .frame(maxWidth: .infinity,alignment:.center)
            
            color.blue_brand_700
                .frame(maxWidth:6,maxHeight: .infinity)
                .cornerRadius(6, corners: [.bottomLeft,.topLeft])
        }
        
    }
    

    
}
