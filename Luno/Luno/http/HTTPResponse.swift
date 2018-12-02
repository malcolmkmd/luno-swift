//
//  HTTPResponse.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum LunoNetworkResponse: String {
    case success
    case authenticationError = "Authentication required."
    case badRequest = "Bad request."
    case outdated = "Outdated URL request."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "Luno could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

extension HTTPURLResponse {
    func handleNetworkResponse() -> Result<String> {
        switch self.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(LunoNetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(LunoNetworkResponse.badRequest.rawValue)
        case 600: return .failure(LunoNetworkResponse.outdated.rawValue)
        default: return .failure(LunoNetworkResponse.failed.rawValue)
        }
    }
}
