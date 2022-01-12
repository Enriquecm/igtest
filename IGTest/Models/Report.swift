//
//  Report.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

struct Report: Codable, Equatable {
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

#if DEBUG
extension Report {
    static var mock: Self {
        return Self(
            title: "Mock Title",
            url: nil,
            description: "Mock Description",
            headlineImageUrl: nil,
            newsKeywords: nil,
            authors: nil,
            instruments: nil,
            tags: ["Tag1", "Tag2", "Tag3", "Tag4"],
            categories: nil,
            displayTimestamp: nil,
            lastUpdatedTimestamp: nil
        )
    }
}
#endif
