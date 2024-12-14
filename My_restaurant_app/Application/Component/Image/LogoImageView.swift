//
//  LogoView.swift
//  aloline-phamkhanhhuy
//
//  Created by Pham Khanh Huy on 27/02/2024.
//

import SwiftUI

struct LogoImageView: View {
    @Environment(\.colorScheme) var colorScheme
    private var backgroundColor:Color { colorScheme == .dark ? .white : .gray.opacity(0.1)}
    
    let imagePath: String
    var width:CGFloat = 50
    var height:CGFloat = 50
    var mold: logoImageMold = .cicrle
    
    var body: some View {
        
        if mold == .cicrle{
            AnimatedAsyncImageView(
                path: imagePath,
                scaleType: .toFill
            )
            .frame(width: width, height: height)
            .padding(2)
            .overlay(Circle().stroke(LinearGradient(
                gradient: Gradient(colors: [.blue, .orange]),
                startPoint: .topLeading,
                endPoint:.bottomTrailing),
                lineWidth:4
            ))
            .clipShape(Circle())
        }else{
            AnimatedAsyncImageView(
                path: imagePath,
                scaleType: .toFill
            )
            .frame(width: width, height: height)
            .cornerRadius(10)
//            .clipShape(Rectangle())
        }
        
    }
    
}

enum logoImageMold {
    case square
    case cicrle
}

#Preview {
    LogoImageView(imagePath:"https://images.examples.com/wp-content/uploads/2019/06/Company-Logo-Design.jpg")
}
