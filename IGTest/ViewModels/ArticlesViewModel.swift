//
//  ArticlesViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Combine
import Foundation

class ArticlesViewModel {
    let reportSectionsSubject = PassthroughSubject<[ReportSection], BusinessError>()

    private weak var coordinator: ArticlesCoordinatorProtocol?
    private let dataSource: DashboardDataSource

    init(coordinator: ArticlesCoordinatorProtocol, dataSource: DashboardDataSource) {
        self.coordinator = coordinator
        self.dataSource = dataSource
    }

    func fetchDashboard() -> AnyPublisher<[ReportSection], BusinessError> {
        return dataSource.requestDashboard()
            .mapError { BusinessError.map($0) }
            .tryCompactMap { try self.process(dashboard: $0) }
            .mapError { BusinessError.map($0) }
            .eraseToAnyPublisher()
    }

    func didSelect(report: Report) {
        coordinator?.didSelect(report: report)
    }
}

extension ArticlesViewModel {
    private func process(dashboard: Dashboard) throws -> [ReportSection] {
        var sections = [ReportSection]()
        // Top News
        if let reports = dashboard.topNews {
            sections.append(ReportSection(title: "Top News", reports: reports))
        }

        // Daily Briefings - EU
        if let reports = dashboard.dailyBriefings?.eu {
            sections.append(ReportSection(title: "Daily Briefings - EU", reports: reports))
        }

        // Daily Briefings - EU
        if let reports = dashboard.dailyBriefings?.asia {
            sections.append(ReportSection(title: "Daily Briefings - Asia", reports: reports))
        }

        // Daily Briefings - US
        if let reports = dashboard.dailyBriefings?.us {
            sections.append(ReportSection(title: "Daily Briefings - US", reports: reports))
        }

        // Technical Analysis
        if let reports = dashboard.technicalAnalysis {
            sections.append(ReportSection(title: "Technical Analysis", reports: reports))
        }

        // Special Report
        if let reports = dashboard.specialReport {
            sections.append(ReportSection(title: "Special", reports: reports))
        }

        if sections.isEmpty {
            throw BusinessError.dashboardNotFound
        } else {
            return sections
        }
    }
}
