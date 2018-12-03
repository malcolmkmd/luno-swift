//
//  LunoAccount.swift
//  Luno
//
//  Created by Malcolm Kumwenda on 2018/12/03.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum LunoAccountError: String, Error {
    case balance, reserved, unconfirmed

    public var localizedDescription: String {
        return "Luno could not convert response \(self.rawValue). into Decimal."
    }
}

public struct LunoAccount {
    let accountId: String
    let asset: String
    let balance: Decimal
    let reserved: Decimal
    let unconfirmed: Decimal
}

extension LunoAccount: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case asset
        case balance
        case reserved
        case unconfirmed
    }

    public init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        accountId = try container.decode(String.self, forKey: .accountId)
        asset = try container.decode(String.self, forKey: .asset)

        let balanceString = try container.decode(String.self, forKey: .balance)
        guard let balanceDecimal = Decimal(string: balanceString) else {
            throw LunoAccountError.balance
        }
        balance = balanceDecimal

        let reservedString = try container.decode(String.self, forKey: .reserved)
        guard let reservedDecimal = Decimal(string: reservedString) else {
            throw LunoAccountError.reserved
        }
        reserved = reservedDecimal

        let unconfirmedString = try container.decode(String.self, forKey: .unconfirmed)
        guard let unconfirmedDecimal = Decimal(string: unconfirmedString) else {
            throw LunoAccountError.unconfirmed
        }
        unconfirmed = unconfirmedDecimal
    }
}
