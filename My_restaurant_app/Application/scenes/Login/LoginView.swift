//
//  LoginView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI
import UIKit
import SwiftUI
import Security

struct LoginView: View {
    @Injected(\.colors) var color: ColorPalette
    @Injected(\.fonts) var font: Fonts
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    @State private var environmentModeTag = 1
    @State private var offlineMode = false
    @State private var isPasswordVisible = false
    @State private var loginUsingCode = false
    
   

    var body: some View {
        VStack(spacing: 20) {
            // App Logo
            Image("tech-logo_cl_#1", bundle: .main) // Replace "logo" with the actual image name in your asset catalog
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 100)
                .padding(.horizontal,50)
                .padding(.top, 100)
        
            LoginForm
            
            BottomPart

        }
        .onAppear{
            viewModel.restaurant = "mttest2o1"
            viewModel.username = "tr000001"
            viewModel.password = "Mtt01234@"
        }
        .padding()
        .background(
            Image("background-login", bundle: .main)
                .resizable()
        ) // Light gray background
        .edgesIgnoringSafeArea(.all)
       
    }
    
    private var LoginForm: some View{
        
        VStack(alignment:.leading,spacing: 15){
            
            Picker("", selection: $environmentModeTag) {
                Text("Online").tag(1)
                Text("Offline").tag(2)
            }
            .frame(width: 150)
            .pickerStyle(.segmented)
            .onChange(of: environmentModeTag) { newValue in
                offlineMode = newValue == 2
                
                if newValue == ONLINE{
                    environmentMode = .online
                }else {
                    environmentMode = .offline
                }
                
            }
            
            if offlineMode{
                // Username Input
                TextField("Ip address", text: $viewModel.ipAddress)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            
            
            // Username Input
            TextField("Công ty/nhà hàng", text: $viewModel.restaurant)
                .padding()
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            
            if !loginUsingCode{
                TextField("Tài khoản", text: $viewModel.username)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            
            if !loginUsingCode{
                HStack {
                    if isPasswordVisible {
                        TextField("Mật khẩu", text: $viewModel.password)
                    } else {
                        SecureField("Mật khẩu", text: $viewModel.password)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }else{
                // Username Input
                TextField("Nhập mã code", text: $viewModel.code)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }

            // Login Button
            Button(action: {
                Task {
                    await viewModel.getSession()
                }
              
            }) {
                Text("ĐĂNG NHẬP")
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.valid ? color.orange_brand_900 : color.gray_600)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.valid)
            .padding(.top, 20)

        }
    }
    
    private var BottomPart: some View{
        VStack{
            
            VStack(alignment:.center,spacing: 20){
                // Forgot Password Link
                Button(action: {
                    loginUsingCode.toggle()
                }) {
                    Text("Đăng nhập bằng mã code")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
                
                // Forgot Password Link
                Button(action: {
                    
                }) {
                    Text("Bạn quên mật khẩu?")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
                
            }
            
            Spacer()
      
            Button(action: {
                // Navigate to registration screen
            }) {
                Text("Đăng ký tài khoản mới")
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
            }
            .padding(.horizontal, 10)
        }
        
        
    }
}

#Preview {
    LoginView()
}


