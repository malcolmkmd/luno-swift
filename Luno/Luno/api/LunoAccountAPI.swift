//
//  LunoAccountAPI.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

/// Accounts
/// All transactions on the Luno platform operate on accounts. Each account is denominated in a single currency and contains an ordered list of entries that track its running balance.
///
/// Each account has a separate balance and available balance. The available balance may be lower than the balance if some funds have been reserved (e.g. for a open limit order). Account entries affect the balance and available balance independently.
///
/// Account entries are numbered sequentially. It is guaranteed that entries are never reordered or deleted. It is also guaranteed that the core attributes of the entry (the running balances and index) are never modified. Therefore, an account acts as an append-only log of transactions. Market data API calls can be accessed by anyone without authentication. The data returned may be cached for up to 1 second. The Streaming API can be used if lower latency market data is needed.
public enum LunoAccountsAPI {

    case createAccount(name: String, currency: LunoCurrency)
    case balance
    case transactions(id: String, minRow: Int, maxRow: Int)
    case pendingTransactions(id: String)

}

extension LunoAccountsAPI: LunoEndPoint {
    var path: String {
        switch self {
        case .createAccount:
            return "accounts"
        case .balance:
            return "balance"
        case .transactions(let id, _, _):
            return "accounts/\(id)/transactions"
        case .pendingTransactions(let id):
            return "accounts/\(id)/pending"
        }
    }

    var task: HTTPTask {
        switch self {
        case .createAccount(let name, let currency):
            return .get(arguments: ["name": name,
                                    "currency": currency])
        case .balance:
            return .get(arguments: nil)
        case .transactions(let id, let minRow, let maxRow):
            return .get(arguments: ["id": id,
                                    "min_row": minRow,
                                    "max_row": maxRow])
        case .pendingTransactions:
            return .get(arguments: nil)
        }
    }

    var requiresAuthentication: Bool {
        return true
    }

}
