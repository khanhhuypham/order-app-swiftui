//
//  EmptyData.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 26/09/2024.
//

import SwiftUI

struct EmptyData: View {
    
    var clickClosure:(() -> Void)? = nil
    @State private var isButtonDisabled = false
    
    var body: some View {
        VStack {
            Image("img-no-data", bundle: .main)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text("Không có dữ liệu")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            Button("Try again") {
                guard !isButtonDisabled else { return }
                               
                isButtonDisabled = true
                clickClosure?()

                // Reset after 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                   isButtonDisabled = false
                }
                
            }
            .buttonStyle(.borderedProminent)
            .disabled(isButtonDisabled)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    EmptyData()
}
