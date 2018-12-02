//
//  LunoPair.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

/// Currency pair e.g XBTZAR (which represents Bitcoin to South African Rands.
public enum LunoPair: String {

    /// Bitcoin to South African Rands.
    case xbtZAR
    /// Ethereum to Bitcoin.
    case ethXBT

    /// API rawValue representation.
    var apiValue: String {
        switch self {
        case .xbtZAR: return "XBTZAR"
        case .ethXBT: return "ETHXBT"
        }
    }
}
