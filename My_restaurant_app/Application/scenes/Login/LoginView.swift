//
//  LoginView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import SwiftUI
import UIKit
import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    @State private var isPasswordVisible = false

    var body: some View {
        VStack(spacing: 20) {
            // App Logo
            Image("tech-logo_cl_#1", bundle: .main) // Replace "logo" with the actual image name in your asset catalog
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 100)
                .padding(.horizontal,50)
                .padding(.top, 100)

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

            // Employee ID Input
            TextField("Tài khoản", text: $viewModel.username)
                .padding()
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )

            // Password Input
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

            // Login Button
            Button(action: {
                viewModel.getSession()
            }) {
                Text("ĐĂNG NHẬP")
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)

            // Forgot Password Link
            Button(action: {
                // Navigate to forgot password screen
            }) {
                Text("Bạn quên mật khẩu?")
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
            }
            .padding(.top, 10)
            
            Spacer()
            
            // Register New Account Link
            Button(action: {
                // Navigate to registration screen
            }) {
                Text("Đăng ký tài khoản mới")
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
            }
            .padding(.horizontal, 10)

        }
        .padding()
        .background(
            Image("background-login", bundle: .main)
                .resizable()
        ) // Light gray background
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoginView()
}


