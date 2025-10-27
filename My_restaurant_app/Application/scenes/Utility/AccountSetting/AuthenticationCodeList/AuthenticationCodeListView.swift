//
//  SettingVIew.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 02/10/2024.
//



import SwiftUI
import AlertToast

struct AuthenticationCodeList: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.utils.toastUtils) private var toast
    @StateObject var viewModel = AuthenticationCodeListViewModel()
    var body: some View {
        
        VStack{
            
            Divider()
            
            HStack{
                Text("Mã code").font(font.b_16).frame(width: 100)
                Spacer()
                Text("Ngày hết hạn").font(font.b_16)
            }
            
            Divider()
            
            if viewModel.list.isEmpty{
                
                EmptyData {
                    Task{
                        await viewModel.getAuthCodeList()
                    }
                }
                
            }else{
                
                List{
                    ForEach(viewModel.list, id:\.id){data in
                        HStack{
                            HStack{
                                Text(data.code).frame(width: 70)
                                Spacer()
                                Button(action: {
                                    
                                    UIPasteboard.general.string = data.code
                                    
                                    toast.alertSubject.send(
                                        AlertToast(displayMode: .hud, type: .complete(.green), title:"Success", subTitle: "Copy dữ liệu thành công")
                                    )
                                }) {
                                    Image(systemName: "doc.on.doc.fill")
                                }
                                .buttonStyle(.plain) // prevents default blue highlight
                            }
                            .frame(width: 100)
                          
                            Spacer()
                            
                            HStack{
                                Text(data.expire_at)
                                Button(action: {
                                    Task{
                                        await viewModel.changeStatusOfAuthenticationCode(id: data.id)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Xoá mã")
                                    }
                                    .font(font.sb_14)
                                    .foregroundColor(.white) // text/icon color
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 12)
                                    .background(color.red_600) // background color
                                    .cornerRadius(18)
                                }
                                .buttonStyle(.plain) // prevents default blue highlight
                            }
                            
                        }
                    }
                    .defaultListRowStyle()
                  
                }
                .listStyle(.plain)
               
            }
            
            Divider()
            
            Button(action: {
                viewModel.createAuthenticationCode(expire_at: dateAfterAddingHoursString(2), code: randomString().uppercased())
            }) {
                Text("TẠO MÃ TOKEN")
                    .font(font.sb_16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height:35)
                    .background(color.orange_brand_900)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 16) // spacing from bottom edge
            .background(Color.white.ignoresSafeArea(edges: .bottom))
          
           
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Danh sách mã hỗ trợ")
                    .font(.headline)
                    .foregroundColor(color.orange_brand_900)
            }
        }
        .task{
            await viewModel.getAuthCodeList()
        }

    }
    
    private func dateAfterAddingHoursString(_ hours: Int) -> String {
        let formatter = dateFormatter.dd_mm_yyyy_hh_mm.value
        let futureDate = Calendar.current.date(byAdding: .hour, value: hours, to: Date()) ?? Date()
        return formatter.string(from: futureDate)
    }
    
    private func randomString(length: Int = 6) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}


#Preview {
    AuthenticationCodeList()
}
