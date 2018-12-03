//
//  LunoRouter.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

/// Completion handler typealias.
public typealias LunoRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

/// LunoRouter
/// Manages URLSession and URLSessionTasks.
public final class LunoRouter {

    enum LunoAuthError: String, Error {
        case noAuth

        public var localizedDescription: String {
            return "No authentication was provided for end point that requires authentication."
        }
    }

    /// Default URL Session
    private let session = URLSession(configuration: .default)
    /// Task
    private var task: URLSessionTask?

    /// Performs a request to given LunoEndPoint.
    func request(_ route: LunoEndPoint, auth: LunoAuth?=nil, completion: @escaping LunoRouterCompletion) throws {

        self.cancel()
        
        do {
            // Build the request.
            var request = try route.buildRequest()

            // Add authentication if needed.
            if let auth = auth, route.requiresAuthentication {
                route.addAuthentication(auth: auth, toRequest: &request)
            } else if route.requiresAuthentication {
                throw LunoAuthError.noAuth
            }

            // Create URLSession dataTask.
            task = session.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }
        } catch {
            throw error
        }

        self.task?.resume()
    }

    /// Cancels any URLSessionTask that is running. 
    func cancel() {
        self.task?.cancel()
    }

}
