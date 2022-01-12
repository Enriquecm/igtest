//
//  Market.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 12/01/22.
//

import Foundation

struct Market: Codable, Equatable {
    let displayName: String?
    let marketId: String?
    let epic: String?
    let rateDetailURL: String?
    let topMarket: Bool?
    let unscalingFactor: Int?
    let unscaledDecimals: Int?
    let calendarMapping: [String]?
}
