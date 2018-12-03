//
//  LunoMarketDataAPI.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/01.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

/// Market Data
/// Market data API calls can be accessed by anyone without authentication. The data returned may be cached for up to 1 second. The Streaming API can be used if lower latency market data is needed.
public enum LunoMarketDataAPI {

    case ticker(pair: LunoPair)
    case tickers
    case orderBookTop(pair: LunoPair)
    case orderBookFull(pair: LunoPair)
    case trades(pair: LunoPair)
    
}

extension LunoMarketDataAPI: LunoEndPoint {
    
    var path: String {
        switch self {
        case .ticker:
            return "ticker"
        case .tickers:
            return "tickers"
        case .orderBookTop:
            return "orderbook_top"
        case .orderBookFull:
            return "orderbook"
        case .trades:
            return "trades"
        }
    }

    var task: HTTPTask {
        switch self {
        case .ticker(let pair),
            .orderBookTop(let pair),
            .orderBookFull(let pair),
            .trades(let pair):
            return .get(arguments: ["pair" : pair.apiValue])
        case .tickers:
            return .get(arguments: nil)
        }
    }

    var requiresAuthentication: Bool {
        return false 
    }
    
}
