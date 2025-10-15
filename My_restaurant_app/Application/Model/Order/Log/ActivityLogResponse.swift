//
//  ActivityLogResponse.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 13/10/25.
//




struct ActivityLogResponse: Codable {
    var limit: Int?
    var data: [ActivityLog] = []
    var total_record: Int?
    
    private enum CodingKeys: String, CodingKey {
        case limit
        case data = "list" // 👈 JSON key was "list"
        case total_record
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.data = try container.decodeIfPresent([ActivityLog].self, forKey: .data) ?? []
        self.total_record = try container.decodeIfPresent(Int.self, forKey: .total_record)
    }
}

struct ActivityLog: Codable {
    var id = 0
    var user_id = 0
    var full_name = ""
    var user_name = ""
    var object_id = 0
    var content = ""
    var created_at = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case user_id
        case full_name
        case user_name
        case object_id
        case content
        case created_at
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = Int(id) ?? 0
        } else {
            self.id = 0
        }
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id) ?? 0
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name) ?? ""
        self.user_name = try container.decodeIfPresent(String.self, forKey: .user_name) ?? ""
        self.object_id = try container.decodeIfPresent(Int.self, forKey: .object_id) ?? 0
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at) ?? ""
    }
}
