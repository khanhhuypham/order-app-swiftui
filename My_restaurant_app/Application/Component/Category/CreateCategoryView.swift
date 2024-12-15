//
//  CreateCategory.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/10/2024.
//

import SwiftUI


struct CreateCategory: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    
    @Binding var isPresent:Bool
    
    @State var category:Category = Category()
   

    var validForm: Bool {
        return true
    }
    

    var onConfirmPress: ((Category) -> Void)? = nil
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {

        VStack{
            Spacer()
            mainContent
            Spacer()
        }.onAppear(perform: {
            
            
        })
        
    }
    
    
    private var mainContent:some View{
        VStack(spacing:0) {
            
            Text(String(format: "%@", category.id == 0 ? "thêm danh mục" : "cập nhật danh mục").uppercased())
                .font(font.sb_16)
                .foregroundColor(color.orange_brand_900)
                .padding(.top,20)
            
            VStack(alignment:.leading,spacing: 15){
//                
                TextField("Tên danh mục", text: $category.name)
                    .font(font.r_13)
                    .commonTextFieldDecor(height: 38)
                
                HStack(spacing:8){
                    
                    Text("Loại danh mục: ")
                  
                    Menu {
                        ForEach(CATEGORY_TYPE.allCases, id: \.self) { cate in
                            Button(action: {
                                category.type = cate
                            }) {
                                Label(cate.name, systemImage: cate == category.type ? "checkmark" : "")
                            }
                         }
                    } label: {
                        Text(category.type.name)
                        .frame(maxWidth:.infinity,alignment:.leading)
                        .commonTextFieldDecor(height: 38)
                    }.disabled(category.id > 0)
                    
                }.font(font.r_13)
                
                
              
            
                if category.id > 0{
         
                    Button(action: {
                        category.active = !category.active
                    }) {
                        HStack{
                            Image(category.active ? "icon-check-square" : "icon-uncheck-square", bundle: .main)
                            Text("ĐANG KINH DOANH")
                                .font(font.r_14)
                                .foregroundColor(.black)
                            
                        }.frame(maxWidth:.infinity,alignment: .leading)
                      
                    }
                }
                
            }
            .padding(.top,30)
            .padding(.bottom,40)
            .padding(.horizontal,20)

       

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
                 
                    
                    if let confirm = self.onConfirmPress,validForm{
                        confirm(category)
                        isPresent = false
                    }
                    
                } label: {
                    Text(String(format: "%@", category.id == 0 ? "thêm" : "cập nhật").uppercased())
                        .font(font.b_18)
                        .frame(maxWidth: .infinity,maxHeight:.infinity)
                        .foregroundColor(.white)
                        .background(validForm ? color.orange_brand_900 : color.gray_600)
                        .disabled(validForm)
            
                }
                .buttonStyle(.plain)
            }.frame(height: 50)
            
        }
        .background(.white)
        .shadowedStyle()
        .cornerRadius(8)
        .padding(.horizontal, 40)
      
    }
    
}



#Preview {
    ZStack {
        Rectangle()
        CreateCategory(isPresent:.constant(true))
    }
   
}

