//
//  Markets.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 10/01/22.
//

import Foundation

struct Markets: Codable, Equatable {
    let currencies: [Market]?
    let commodities: [Market]?
    let indices: [Market]?
}

#if DEBUG
extension Markets {
    static var mock: Self {
        return Self(
            currencies: [Market.mock, Market.mock],
            commodities: [Market.mock],
            indices: [Market.mock, Market.mock, Market.mock]
        )
    }
}
#endif
