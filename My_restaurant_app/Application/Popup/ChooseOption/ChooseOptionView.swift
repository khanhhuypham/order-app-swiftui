//
//  ChooseOptionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 08/07/2025.
//

import SwiftUI

struct ChooseOptionView: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = ChooseOptionViewModel()
    var item:Food = Food()
    var onSubmit:((Food) -> Void)? = nil
    
    var body: some View {
        
        VStack{
            ScrollView(showsIndicators: false){
                
                VStack(alignment:.leading){
                    
                    LogoImageView(imagePath: "",width:.infinity,height: 150,mold:.square)
                    
                    HStack{
                        Text(viewModel.item.name).font(.system(size: 24,weight: .bold))
                        Spacer()
                        Text(viewModel.item.price.toString).font(.system(size: 24,weight: .bold))
                    }
                    
                    QuantityView(width: 25,height:25, quantity: $viewModel.item.quantity){(type,quantity) in
                      
                        switch type{
                            case .minus:
                                viewModel.item.quantity = quantity - 1
                                if  viewModel.item.quantity <= 0{
                                    viewModel.item.quantity = 0
                                    viewModel.item.isSelect = false
                                }
                            
                            case .plus:
                                viewModel.item.quantity = quantity + 1
                            
                            default:
                                viewModel.item.quantity = quantity
                                if  viewModel.item.quantity >= 999{
                                    viewModel.item.quantity = 999
                                }
                                
                        }
                       
                    }
                  
                    ForEach($viewModel.item.food_options){option in
                        OptionSectionView(option: option)
                    }
                    
                    VStack{
                        HStack{
                            Text("Note to restaurant")
                                .font(.system(size: 24,weight: .bold))
                            
                            Spacer()
                            
                            Text("Optional")
                                .font(font.m_12)
                                .padding(.horizontal,14)
                                .padding(.vertical,7)
                                .background(color.gray_200)
                                .clipShape(Capsule())
                        }
                            
                        ZStack(alignment: .topLeading) {
                            // Placeholder text
                            TextEditor(text: $viewModel.item.note).onChange(of: viewModel.item.note, perform: { text in

                            })
                            
                            if viewModel.item.note.isEmpty {
                                Text("Ghi chú")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                            }
                            
                        }
                        .font(font.r_14)
                        .frame(height: 80)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(color.gray_600, lineWidth: 0.8))
                        
                        TagListLayout(viewModel.noteList, spacing: 4){ note in
                            Text(note.content)
                               .font(font.m_12)
                               .padding(.horizontal, 14)
                               .padding(.vertical, 7)
                               .background(color.orange_brand_900)
                               .foregroundColor(.white)
                               .cornerRadius(5)
                               .onTapGesture(perform: {
                                   if let position = viewModel.noteList.firstIndex(where: {$0.id == note.id}){
                                       viewModel.noteList.remove(at: position)
                                   }
                               })
        
                        }

                                          
                    }
                }
             
            }
          
            Button(action: {
                var item = viewModel.item
                item.isSelect = true
                onSubmit?(item)
                dismiss()
            }) {
                Text("THÊM VÀO GIỎ HÀNG")
                    .font(font.sb_16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height:40)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
            }
            .padding(.top,20)
            
        }.onAppear(perform: {
            viewModel.item = item
            viewModel.firstSetup()
        })
        .padding()
    }
    
}

