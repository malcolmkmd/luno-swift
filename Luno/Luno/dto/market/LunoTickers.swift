//
//  LunoTickers.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct LunoTickers: Decodable {
    let tickers: [LunoTicker]
}

extension LunoTickers: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """

        \(self.tickers)

        """
    }
}
