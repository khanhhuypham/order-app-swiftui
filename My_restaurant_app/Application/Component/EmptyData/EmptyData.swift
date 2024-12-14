//
//  EmptyData.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 26/09/2024.
//

import SwiftUI

struct EmptyData: View {
    var body: some View {
        VStack {
            Image("img-no-data", bundle: .main)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text("No Data Available")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            Button("Try again") {
                
            }.buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    EmptyData()
}
