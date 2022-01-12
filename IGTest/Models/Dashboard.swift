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

#if DEBUG
extension Dashboard {
    static var mock: Self {
        return Self(
            topNews: [Report.mock, Report.mock],
            dailyBriefings: nil,
            technicalAnalysis: [Report.mock],
            specialReport: [Report.mock, Report.mock, Report.mock]
        )
    }
}
#endif
