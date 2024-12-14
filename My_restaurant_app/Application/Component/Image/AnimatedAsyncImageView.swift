//
//  AnimatedAsyncImageView.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 02/10/2024.
//

import SwiftUI

struct AnimatedAsyncImageView: View {
    private var url: URL? {
        URL(string: path)
    }
    
    let path: String
    var scaleType: ScaleTypes? = .toFill
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                
             
                if let image = phase.image {
                    if scaleType! == .toFill {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    
                    Image("image_default",bundle: .main)
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.primary)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)

        }
    }
}

#Preview {
    AnimatedAsyncImageView(
        path:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVnSgLucTHuu1zcVRajpObRRu8VcKn84D5fA&usqp=CAU",
        scaleType: .toFit
    )
}

enum ScaleTypes {
    case toFit
    case toFill
}
