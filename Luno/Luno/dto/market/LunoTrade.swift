//
//  LunoTrade.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct LunoTrade {
    let timestamp: Date
    let price: Decimal
    let volume: Decimal
    let isBuy: Bool
}

extension LunoTrade: Decodable {
    private enum CodingKeys: String, CodingKey {
        case timestamp
        case price
        case volume
        case isBuy = "is_buy"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        timestamp = try container.decode(Date.self, forKey: .timestamp)

        let volumeString = try container.decode(String.self, forKey: .volume)
        guard let volumeDecimal = Decimal(string: volumeString) else {
            throw LunoBidError.volume
        }
        volume = volumeDecimal

        let priceString = try container.decode(String.self, forKey: .price)
        guard let priceDecimal = Decimal(string: priceString) else {
            throw LunoBidError.price
        }
        price = priceDecimal

        isBuy = try container.decode(Bool.self, forKey: .isBuy)
    }
}

extension LunoTrade: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """

        - - - LUNO TRADE - - -
        Time Stamp = \(self.timestamp)
        Price = \(self.price)
        Volume = \(self.volume)
        isBuy = \(self.isBuy)

        """
    }
}
