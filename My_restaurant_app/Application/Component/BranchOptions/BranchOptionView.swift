//
//  BranchOptionView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 04/10/2024.
//

import SwiftUI

struct BranchOptionView: View {

    @Environment(\.dismiss) var dismiss
    @Injected(\.fonts) private var fonts
       
    @ObservedObject var viewModel: BranchOptionViewModel = BranchOptionViewModel()
    
    var body: some View {
        VStack{
            Text(viewModel.type == 1 ? "Vui lòng chọn thương hiệu" : "Vui lòng chọn chi nhánh")
               .font(.headline)
               .frame(maxWidth:.infinity,alignment:.center)
               .frame(height: 60)
               .background(Color(ColorUtils.orange_brand_900()))
               .foregroundColor(.white)

                       
            // Search Bar
            searchBar
            
            if viewModel.type == 1{
                
                List($viewModel.brands) { brand in
                    brandItem(brand: brand)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain) // Remove default separators
                
            }else{
                List($viewModel.branches) { branch in
                    branchItem(branch: branch)
                        .defaultListRowStyle()
                        .background(.white)
                }
                .listStyle(.plain)
                
            }
            
            

        }.onAppear {
            viewModel.getBrands()
        }
    }
    
    
    
    
    
    private var searchBar:some View{
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.horizontal,10)
            
            TextField("Tìm kiếm", text: $viewModel.searchText)
                .padding(.trailing,10)
    
        }
        .frame(height: 35)
        .overlay(RoundedRectangle(cornerRadius: 17).stroke(Color.orange, lineWidth: 2))
        .padding(.horizontal,18)
        .foregroundColor(Color(ColorUtils.orange_brand_900()))
    }
    
    private func brandItem(brand:Binding<Brand>) -> some View{
        
        
       return Button(action: {
           viewModel.getBranches(brand: brand.wrappedValue)
       }){
           HStack {
//
//               let link_image = Utils.getFullMediaLink(string: data?.logo_url ?? "")
//               avatar_branch.kf.setImage(with: URL(string: link_image), placeholder: UIImage(named: "image_defauft_medium"))
//               icon_check.image = UIImage(named: data?.id == ManageCacheObject.getCurrentBrand().id ? "icon-check-green" : "")
               
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray) // or a custom image
               
                Text(brand.wrappedValue.name ?? "")
                   .font(fonts.r_14)
               
                Spacer()
               
               if brand.wrappedValue.id == Constants.brand.id {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
           }
           .padding()
           .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(ColorUtils.orange_brand_900()), lineWidth:1))
           .background(Color(ColorUtils.orange_brand_200()))
       } .buttonStyle(.plain)
        
    }
    
    private func branchItem(branch:Binding<Branch>) -> some View{
        
        
       return Button(action: {
        
           SettingUtils.getBranchSetting(branchId: branch.wrappedValue.id ?? 0,completion: {dismiss()})
           
           
       }){
           HStack {
//               let link_image = Utils.getFullMediaLink(string: data?.image_logo ?? "")
//               avatar_branch.kf.setImage(with: URL(string: link_image), placeholder: UIImage(named: "image_defauft_medium"))
//               lbl_address.text = data?.address
//               
//               icon_check.image = UIImage(named: ManageCacheObject.getCurrentBranch().id == data?.id ? "icon-check-green" : "")
               
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 20, height: 20)
                   
               
                VStack(alignment:.leading){
                    
                   Text(branch.wrappedValue.name ?? "")
                      .font(fonts.r_14)
                     
                  
                   Text(branch.wrappedValue.address ?? "")
                      .font(fonts.r_12)
                      .foregroundColor(Color(ColorUtils.gray_600()))
                    
                    
                }
             
              
                Spacer()
               
                if branch.wrappedValue.id == Constants.branch.id {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
           }
           .padding()
       }
        
    }
    
}

#Preview {
    BranchOptionView()
}
