//
//  Dashboard.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

struct Dashboard: Codable, Equatable {
    let topNews: [Report]?
    let dailyBriefings: DailyBriefings?
    let technicalAnalysis, specialReport: [Report]?
}
