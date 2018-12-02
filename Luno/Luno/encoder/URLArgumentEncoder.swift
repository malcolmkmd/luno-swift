//
//  URLArgumentEncoder.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum LunoURLEncoderError: Error {
    case noUrl

    public var localizedDescription: String {
        switch self {
        case .noUrl:
            return "Luno could not encode request with nil url."
        }
    }
}

public struct LunoURLArgumentEncoder {
    public static func encode(urlRequest: inout URLRequest, with arguments: [String:Any]?) throws {

        guard let url = urlRequest.url else { throw LunoURLEncoderError.noUrl }

        if let arguments = arguments, var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !arguments.isEmpty {

            urlComponents.queryItems = [URLQueryItem]()

            for (key,value) in arguments {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }

    }
}
