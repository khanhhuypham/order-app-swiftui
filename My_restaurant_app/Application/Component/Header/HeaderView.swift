import SwiftUI

struct HeaderView: View {
    @Injected(\.fonts) var font: Fonts
    @Injected(\.colors) var color: ColorPalette
    @Binding var searchText:String
    @Binding var btnArray:[(id:Int,title:String,isSelected:Bool)]
  
    
    var clickClosure:((Int) -> Void)? = nil
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack {
                // Search bar with icon
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(color.orange_brand_900)
                        .padding(.leading,10)

                    TextField("Tìm kiếm", text: $searchText)
                        .padding(.trailing,20)
                        
                }
                .frame(width:200,height: 34)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(color.orange_brand_900, lineWidth: 2))
                .padding(.horizontal,15)
                
                ForEach(Array(btnArray.enumerated()), id: \.offset){i,element in
                    // "Món ăn" Button
                    Button(action: {
                        // Action for Món ăn
                        for (j,btn) in btnArray.enumerated(){
                            btnArray[j].isSelected = i == j ? true : false
                        }
                        if let clickClosure = self.clickClosure{
                            clickClosure(element.id)
                        }
                     
                        
                    }) {
                        Text(element.title)
                            .font(font.sb_14)
                            .foregroundColor(color.orange_brand_900)
                    }
                    .padding(.horizontal,10)
                    .overlay(
                        Rectangle()
                            .frame(height: element.isSelected ? 5 : 0) // Height of the underline
                            .foregroundColor(.orange) // Color of the underline
                            .offset(y: 15) // Adjust position of the underline
                            .opacity(0.7) // Adjust opacity if needed
                        ,alignment: .bottom
                    )
                    
                }
                
            }
            .frame(maxHeight:.infinity)
            .padding(.horizontal)
            .padding(.vertical,0)
        }
        .frame(height: 60)
        
       
    }
}


#Preview(body: {
    
     ZStack{
        
        Rectangle()
        
         HeaderView(searchText:.constant(""),btnArray: .constant([]))
            .frame(maxHeight:100).background(.white)
        
    }
    
})
