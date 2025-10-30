//
//  DefaultNetworkClient.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: NetworkManager) async -> Result<T, Error>
}

final class DefaultNetworkClient: NetworkClient {
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: NetworkManager) async -> Result<T, Error> {
        do {
            let request = try NetworkManager.makeRequest(from: endpoint, url: baseURL)
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.unknown)
            }

            switch httpResponse.statusCode {
                case 200...299:
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return .success(decoded)
                default:
                    return .failure(NetworkError.serverError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8)))
                }
        } catch {
            return .failure(error)
        }
    }
}
