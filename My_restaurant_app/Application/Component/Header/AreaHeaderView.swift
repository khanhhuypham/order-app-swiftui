//
//  AreaHeader.swift
//  SwiftUI-demo
//
//  Created by Pham Khanh Huy on 09/09/2024.
//

import SwiftUI


struct AreaHeader: View {
    @Injected(\.fonts) var fonts: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Binding var areaArray:[Area]
    
    var closure:(() -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(alignment:.center,spacing:15){
        
                ForEach(Array(areaArray.enumerated()), id: \.offset){i,element in
                    // "Món ăn" Button
                    Button(action: {
                        
                        // Action for Món ăn
                        for (j,btn) in areaArray.enumerated(){
                            areaArray[j].isSelect = i == j ? true : false
                        }
                        
                        if let closure = self.closure{
                            closure()
                        }
                
                    }) {
                        Text(element.name)
                            .font(fonts.sb_14)
                            .foregroundColor(element.isSelect ? .white : color.orange_brand_900)
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 25, style: .circular)
                            .stroke(color.orange_brand_900, lineWidth: 2)
                        
                    )
                    .background(element.isSelect ? color.orange_brand_900 : .white)
                    .cornerRadius(25)
              
                }
                
            }
            .frame(height: 50)
            .padding(.horizontal)
        }
        
    }
}



#Preview(body: {

    var jsonString = """
       [
               {
                   "id": 0,
                   "name": "Tất cả",
                   "status": 1,
                   "table_count": 4,
                   "is_take_away": 0
               },
               {
                   "id": 7590,
                   "name": "KHU A",
                   "status": 1,
                   "table_count": 4,
                   "is_take_away": 0
               },
               {
                   "id": 7591,
                   "name": "KHU B",
                   "status": 1,
                   "table_count": 4,
                   "is_take_away": 0
               }
        ]
    """
    
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            // Decode the JSON into a User instance
            let array = try JSONDecoder().decode([Area].self, from: jsonData)
            
            return 
            ZStack {
                Rectangle()
                AreaHeader(areaArray: .constant(array)).background(.white)
                
           }
        } catch {
          
            return Text("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    return EmptyView()
    

})
