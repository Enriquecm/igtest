//
//  Report.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

struct Report: Codable {
    let title: String?
    let url: String?
    let description: String?
    let headlineImageUrl: String?
    let newsKeywords: String?
    let authors: [Author]?
    let instruments: [String]?
    let tags: [String]?
    let categories: [String]?
    let displayTimestamp: Int?
    let lastUpdatedTimestamp: Int?
}
