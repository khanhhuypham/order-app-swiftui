//
//  PlainAPIResponse.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 8/12/25.
//


struct PlainAPIResponse: Codable {

    var status: HTTPStatusCode
    var message: String

  
    private enum CodingKeys: String, CodingKey {
        case status, message
    }
    
    
}