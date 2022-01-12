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
