//
//  SettingVIew.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 02/10/2024.
//



import SwiftUI
import UIKit

struct SettingVIew: View {
    @EnvironmentObject var tabbarRouter:TabBarViewModel
    
    @Injected(\.fonts) private var fonts

    @State private var showingAlert = false
    @State var loginSetting: Bool = false
    @State private var languageIndex = 0
    var languageOptions = ["Vietnamese","English", "Japanese"]
    
    var body: some View {
        let GPBH = String(format: "Version: %@ (GPBH%d-OPTION-0%d)","0",Constants.setting.branch_type,Constants.setting.branch_type_option)
        
        Form{
            Group{

                
                Section(header: Text("Tài Khoản"), content: {
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        HStack{
                            Image(uiImage: UIImage(systemName: "key.icloud.fill")!)
                            Text("Cập nhật tài khoản")
                        }
                    }
                    
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        HStack{
                            Image(uiImage: UIImage(systemName: "key.icloud.fill")!)
                            Text("Đổi mật khẩu")
                        }
                    }
                    
                    NavigationLink{
                        AuthenticationCodeList()
                    } label: {
                        
                        HStack{
                            Image(uiImage: UIImage(systemName: "bitcoinsign.circle")!)
                            Text("Lấy mã hỗ trợ")
                        }
                    }
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        
                        HStack{
                            Image(uiImage: UIImage(systemName: "phone.badge.waveform.fill")!)
                            Text("Hỗ trợ kỹ thuật")
                        }
                    }
            
                })
                
                Section(header: Text("Quyền riêng tư"), content: {
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        
                        HStack{
                            Image(uiImage: UIImage(systemName: "person.slash.fill")!)
                            Text("Chặn")
                        }
                    }
        
                })
                
                Section(header: Text("Tuỳ chọn"), content: {
                    
                    HStack{
                        Image(uiImage: UIImage(systemName: "location.fill")!)
                        VStack(alignment:.leading){
                            Text("Quốc gia")
                            Text("Việt Nam")
                                .font(fonts.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    HStack{
                        Image(uiImage: UIImage(systemName: "globe.asia.australia.fill")!)
                        Picker(
                            selection: $languageIndex,
                            content: {
                                ForEach(0 ..< languageOptions.count) {
                                    Text(self.languageOptions[$0])
                                }
                            }, label: {
                                VStack(alignment:.leading){
                                    Text("Ngôn ngữ")

                                    Text(languageOptions[languageIndex])
                                        .font(fonts.footnote)
                                        .foregroundColor(.gray)    
                                }
                        })
                    }
                    
                    HStack{
                        Image(uiImage: UIImage(systemName: "lock.open")!)
                        
                        Toggle(isOn: $loginSetting){
                            VStack(alignment:.leading){
                                Text("Cài đặt đăng nhập")
                                
                                Text("Bạn có thể lựa chọn đăng nhập bằng mật khẩu. vân tay hoặc Face ID")
                                    .font(fonts.footnote)
                                    .foregroundColor(.gray)
                            }
                        
                        }
                    }
                })
                
                Section(header: Text("Điều khoản và chính sách bảo mật"), content: {
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        
                        HStack{
                            Image("icon-square-badge-exclamation.fill", bundle: .main)
                            
                            VStack(alignment:.leading){
                                Text("Gửi thông báo lỗi")
                                
                                Text("Đóng góp ý kiến giúp cho nhà phát triển hoàn thiện sản phẩm tốt hơn")
                                    .font(fonts.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                    }
                    
                    
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        
                        HStack{
                            Image("icon-envelop.fill", bundle: .main)
                            
                            VStack(alignment:.leading){
                                Text("Đóng ý nhà phát triển")
                                
                                Text("Đóng góp ý kiến giúp cho nhà phát triển hoàn thiện sản phẩm tốt hơn")
                                    .font(fonts.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                    }
                    
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        HStack{
                            Image(uiImage: UIImage(systemName: "book.pages.fill")!)
                            Text("Điều khoản sử dụng")
                        }
                    }
                    
                
                    NavigationLink{
                        EmptyView()
                    } label: {
                        HStack{
                            Image(uiImage: UIImage(systemName: "lock.fill")!)
                            
                            VStack(alignment:.leading){
                                Text("Chính sách bảo mật")
                                
                                Text("Những chính sách liên quan tới bảo mật thông tin")
                                    .font(fonts.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
                        HStack{
                            Image(uiImage: UIImage(systemName: "star.fill")!)
                            
                            VStack(alignment:.leading){
                                Text("Đánh giá ứng dụng")
                                
                                Text("Đánh giúp ứng dụng tốt hơn")
                                    .font(fonts.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    NavigationLink{
                        EmptyView()
                    } label: {
            
                        HStack{
            
                            Image("icon-knight-chess.fill", bundle: .main)
                            
                            VStack(alignment:.leading){
                                Text("Thông tin ứng dụng")
                                
                                Text(GPBH)
                                    .font(fonts.footnote)
                                    .foregroundColor(.gray)
                                
                            }

                        }
                    }
        
                })
                
                HStack(content: {
                    
                    Spacer()
                    Button(action: {
                        showingAlert = true
                    }, label: {
                        HStack(alignment:.center){
                            Image(systemName: "arrowshape.backward.circle.fill")
                            Text("ĐĂNG XUẤT")
                        }
                        .padding(.vertical, 5)
                    })
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("XÁC NHẬN ĐĂNG XUẤT"),
                            message: Text("đăng xuất khỏi tài khoản này?"),
                            primaryButton: .destructive(Text("ĐỒNG Ý")) {
                                withAnimation {
                                    AppState.shared.userState = .notLoggedIn
                                    
                                    ManageCacheObject.setBrand(Brand())
                                    ManageCacheObject.setBranch(Branch())
                                    ManageCacheObject.saveAccountSetting(AccountSetting())
                                    ManageCacheObject.saveUser(Account())
                                    ManageCacheObject.setConfig(Config())
                                }
                            },
                            secondaryButton: .cancel(Text("HUỶ"))
                        )
                    }
                    Spacer()
                })
                
            }
            
        }.navigationBarTitle("Tài khoản")

    }
}


#Preview {
    SettingVIew()
}
