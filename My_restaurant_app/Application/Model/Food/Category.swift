//
//  Category.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 22/09/2024.
//

struct Category: Identifiable, Codable {
    var id: Int = 0
    var name: String = ""   
    var active: Bool = false
    var type: CATEGORY_TYPE = .food
    var description: String?
    /*
        biến này chỉ sử dụng riêng cho module ReportBusinessAnalystic
        vì api của module này dùng chung với model category
        
        biến này sẽ dc chỉnh sửa lại sau khi có thời gian
     */
    // var type:Int = 0

    var isSelect: Bool = false

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case active
        case type
    }
    
    init(){}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        active = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        type = try container.decodeIfPresent(CATEGORY_TYPE.self, forKey: .type) ?? .food
    }
}
