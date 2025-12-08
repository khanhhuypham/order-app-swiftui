//
//  APIResponse.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//



struct APIResponse<T: Codable>: Codable {
    var data: T?
    var status: HTTPStatusCode
    var message: String

  
    private enum CodingKeys: String, CodingKey {
        case data
        case status
        case message
    }
    
}


enum AppResult<T> {
    case success(T?)
    case failure(Error?)
}

