//
//  LunoBalance.swift
//  Luno
//
//  Created by Malcolm Kumwenda on 2018/12/03.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct LunoBalance: Decodable {
    let balance: [LunoAccount]
}
