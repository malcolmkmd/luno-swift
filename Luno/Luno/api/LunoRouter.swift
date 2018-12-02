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

    /// Default URL Session
    private let session = URLSession(configuration: .default)
    /// Task
    private var task: URLSessionTask?

    /// Performs a request to given LunoEndPoint.
    func request(_ route: LunoEndPoint, completion: @escaping LunoRouterCompletion) throws {

        self.cancel()
        
        do {
            let request = try route.buildRequest()
            print(request.description)
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
