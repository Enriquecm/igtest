//
//  MarketsEndpoint.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 10/01/22.
//

import Foundation

struct MarketsEndpoint: Endpoint {
    var path: String
    var method: HTTPMethod
}

extension MarketsEndpoint {
    static func getMarkets() -> MarketsEndpoint {
        MarketsEndpoint(path: "markets", method: .get(.empty))
    }
}
