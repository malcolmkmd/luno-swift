//
//  LunoOrderBook.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct LunoOrderBook: Decodable {
    let timestamp: Date
    let bids: [LunoBid]
    let asks: [LunoBid]
}

extension LunoOrderBook: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """

        - - - LUNO ORDERBOOK - - -
        Time Stamp = \(self.timestamp)
        Bids = \(self.bids)
        Asks = \(self.asks)

        """
    }
}

