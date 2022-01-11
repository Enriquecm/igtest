//
//  DailyBriefings.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

struct DailyBriefings: Codable, Equatable {
    let eu, asia, us: [Report]?
}
