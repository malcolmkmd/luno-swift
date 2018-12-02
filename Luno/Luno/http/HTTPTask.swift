//
//  HTTPTask.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/01.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case get(arguments: [String:Any]?)
    case post(arguments: [String:Any]?)
}
