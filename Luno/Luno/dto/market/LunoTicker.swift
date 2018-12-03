//
//  Ticker.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/01.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum LunoTickerError: String, Error {
    case bid
    case ask
    case lastTrade
    case rolling24HourVolume

    public var localizedDescription: String {
        return "Luno could not convert response \(self.rawValue). into Decimal."
    }
}

public struct LunoTicker {
    let timestamp: Date
    let bid: Decimal
    let ask: Decimal
    let lastTrade: Decimal
    let rolling24HourVolume: Decimal
    let pair: String
}

extension LunoTicker: Decodable {
    private enum CodingKeys: String, CodingKey {
        case timestamp
        case bid
        case ask
        case lastTrade
        case rolling24HourVolume = "rolling_24_hour_volume"
        case pair
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        timestamp = try container.decode(Date.self, forKey: .timestamp)
        pair = try container.decode(String.self, forKey: .pair)

        let bidString = try container.decode(String.self, forKey: .bid)
        guard let bidDecimal = Decimal(string: bidString) else {
            throw LunoTickerError.bid
        }
        bid = bidDecimal

        let askString = try container.decode(String.self, forKey: .ask)
        guard let askDecimal = Decimal(string: askString) else {
            throw LunoTickerError.ask
        }
        ask = askDecimal

        let lastTradeString = try container.decode(String.self, forKey: .ask)
        guard let lastTradeDecimal = Decimal(string: lastTradeString) else {
            throw LunoTickerError.lastTrade
        }
        lastTrade = lastTradeDecimal

        let rolling24HourVolumeString = try container.decode(String.self, forKey: .rolling24HourVolume)
        guard let rolling24HourVolumeDecimal = Decimal(string: rolling24HourVolumeString) else {
            throw LunoTickerError.rolling24HourVolume
        }
        rolling24HourVolume = rolling24HourVolumeDecimal
    }
}

extension LunoTicker: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """

            - - - LUNO TICKER - - -
            Time Stamp = \(self.timestamp)
            Bid = \(self.bid)
            Ask = \(self.ask)
            Last Trade = \(self.lastTrade)
            Rolling 24 Hour Volume = \(rolling24HourVolume)
            Pair = \(self.pair)
        
        """
    }
}

