//
//  LunoEndPoint.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/01.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

protocol LunoEndPoint {
    /// Base URL
    var baseURL: URL { get }
    /// Path
    var path: String { get }
    /// HTTP task e.g get, post
    var task: HTTPTask { get }
    /// Determines if authentication is needed for the specific end point. 
    var requiresAuthentication: Bool { get }
}

extension LunoEndPoint {
    var baseURL: URL {
        guard let baseURL = URL(string: "https://api.mybitx.com/api/1/") else {
            fatalError("Luno could not instantiate base URL.")
        }

        return baseURL
    }
}

extension LunoEndPoint {
    func buildRequest() throws -> URLRequest {
        var request = URLRequest(url: self.baseURL.appendingPathComponent(self.path))

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        switch self.task {
        case .get(let arguments):
            request.httpMethod = "GET"
            try LunoURLArgumentEncoder.encode(urlRequest: &request, with: arguments)
        case .post(let arguments):
            request.httpMethod = "POST"
            try LunoURLArgumentEncoder.encode(urlRequest: &request, with: arguments)
        }

        return request
    }

    func addAuthentication(auth: LunoAuth, toRequest request: inout URLRequest) {
        let authString = "\(auth.key):\(auth.secret)"

        guard let authData = authString.data(using: .utf8) else {
            return
        }

        let base64AuthString = authData.base64EncodedString()
        request.addValue("Basic \(base64AuthString)",
            forHTTPHeaderField: "Authorization")
    }
}
