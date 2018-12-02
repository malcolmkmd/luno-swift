//
//  Luno.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/01.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

/// Luno API Client
public final class Luno {

    // MARK: - Private Properties

    /// API Router 
    private let router = LunoRouter()
    /// Luno API Key
    private let apiKey: String
    /// Luno API Secret
    private let secret: String

    // MARK: - Initialiser

    /// Initialises a Luno API Client.
    /// - Parameter apiKey: API Key attained from https://www.luno.com/wallet/settings/api_keys (ensure that you do not commit this key).
    /// - Parameter secret: Secret attained from https://www.luno.com/wallet/settings/api_keys (ensure that you do not commit this secret).
    public init(usingAPIKey apiKey: String,
         andSecret secret: String) {
        self.apiKey = apiKey
        self.secret = secret
    }

    // MARK: - MARKET DATA 

    /// Returns the latest ticker indicators.
    /// - Parameter pair: Currency pair
    /// - Parameter ticker: LunoTicker
    /// - Parameter error: Localized error description.
    public func ticker(pair: LunoPair, completion: @escaping (_ ticker: LunoTicker?, _ error: String?) -> Void) {
        self.performRequest(endPoint: LunoMarketDataAPI.ticker(pair: pair),
                            completion: completion)
    }

    /// Returns the latest ticker indicator from all active Luno exchanges.
    /// - Parameter tickers: Luno Tickers, contains an array of LunoTicker.
    /// - Parameter error: Localized error description.
    public func tickers(completion: @escaping (_ tickers: LunoTickers?, _ error: String?) -> Void) {
        self.performRequest(endPoint: LunoMarketDataAPI.tickers,
                            completion: completion)
    }

    /// Returns a list of the top 100 bids and asks in the order book. Ask orders are sorted by price ascending. Bid orders are sorted by price descending. Orders of the same price are aggregated.
    /// - Parameter pair: Currency pair
    /// - Parameter orderBook: LunoOrderBook
    /// - Parameter error: Localized error description.
    public func orderBookTop(pair: LunoPair, completion: @escaping (_ orderBook: LunoOrderBook?, _ error: String?) -> Void) {
        self.performRequest(endPoint: LunoMarketDataAPI.orderBookTop(pair: pair),
                            completion: completion)
    }

    /// Returns a list of all bids and asks in the order book. Ask orders are sorted by price ascending. Bid orders are sorted by price descending. Multiple orders at the same price are not aggregated.

    /// Warning: This may return a large amount of data. Generally you should rather use GetOrderBook or the Streaming API.
    /// - Parameter pair: Currency pair
    /// - Parameter orderBook: LunoOrderBook
    /// - Parameter error: Localized error description.
    public func orderBookFull(pair: LunoPair, completion: @escaping (_ orderBook: LunoOrderBook?, _ error: String?) -> Void) {
        self.performRequest(endPoint: LunoMarketDataAPI.orderBookTop(pair: pair),
                            completion: completion)
    }

    /// Returns a list of the most recent trades. At most 100 results are returned per call.
    /// - Parameter pair: Currency pair
    /// - Parameter trades: LunoTrade
    /// - Parameter error: Localized error description.
    public func trades(pair: LunoPair, completion: @escaping (_ trades: LunoTrades?, _ error: String?) -> Void) {
        self.performRequest(endPoint: LunoMarketDataAPI.trades(pair: pair),
                            completion: completion)
    }

}

// MARK: - Request Helper Method
extension Luno {
    
    /// Performs request to the provided end point, decodes response and handles any errors.
    /// - Parameter endPoint: LunoEndPoint from which the request will be built.
    /// - Parameter decodable: Decoded model returned with the response;
    /// - Parameter error: Localized error description.
    private func performRequest<EndPoint: LunoEndPoint, T: Decodable>(endPoint: EndPoint,
                                                                      completion: @escaping (_ decodable: T?, _ error: String?) -> Void) {
        do {

            // Perform request.
            try router.request(endPoint) { (data, response, error) in

                // Check that error is nil.
                if error != nil {
                    completion(nil, error?.localizedDescription)
                }

                // Check the response
                if let response = response as? HTTPURLResponse {
                    let result = response.handleNetworkResponse()
                    switch result {
                    case .success:

                        // Check that data is returned.
                        guard let responseData = data else {
                            completion(nil, LunoNetworkResponse.noData.rawValue)
                            return
                        }

                        // Decode the returned data.
                        do {
                            let model = try JSONDecoder().decode(T.self, from: responseData)
                            completion(model,nil)
                        }catch {
                            completion(nil, error.localizedDescription)
                        }

                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        } catch {
            completion(nil, error.localizedDescription)
        }
    }
}
