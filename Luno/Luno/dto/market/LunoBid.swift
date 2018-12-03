//
//  LunoBid.swift
//  LunoAPIClient
//
//  Created by Malcolm Kumwenda on 2018/12/02.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum LunoBidError: String, Error {
    case volume
    case price

    public var localizedDescription: String {
        return "Luno could not convert response \(self.rawValue). into Decimal."
    }
}

public struct LunoBid {
    let volume: Decimal
    let price: Decimal
}

extension LunoBid: Decodable {
    private enum CodingKeys: String, CodingKey {
        case volume
        case price
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

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
    }
}

extension LunoBid: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """

        - - - LUNO BID - - -
        volume = \(self.volume)
        price = \(self.price)

        """
    }
}
