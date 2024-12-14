//
//  Category.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/09/2024.
//


struct Category: Codable,Identifiable {
    
    var id:Int = 0
    var name:String = ""
    var description:String?
    var active:Bool = false
    var type:CATEGORY_TYPE = .processed
    
    /*
        biến này chỉ sử dụng riêng cho module ReportBusinessAnalystic
        vì api của module này dùng chung với model category
        
        biến này sẽ dc chỉnh sửa lại sau khi có thời gian
     */
//    var type:Int = 0
    
    var isSelect:Bool = false
    

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case active
        case type
    }
}
