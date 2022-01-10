//
//  DashboardDataSource.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Combine
import Foundation

struct DashboardDataSource {
    let requestDashboard: () -> AnyPublisher<Dashboard, NetworkError<DiscardableResult>>
}

extension DashboardDataSource {
    static func live(api: DailyFxAPIProtocol) -> DashboardDataSource {
        return DashboardDataSource(
            requestDashboard: { api.requestDashboard() }
        )
    }

    #if DEBUG
//    static let mock = DashboardDataSource(
//        requestDashboard: { _, _ in
//            CurrentValueSubject<Dashboard, NetworkError<DiscardableResult>>(Dashboard.mock).eraseToAnyPublisher()
//        }
//    )

    static let failed = DashboardDataSource(
        requestDashboard: {
            Fail<Dashboard, NetworkError<DiscardableResult>>(
                error: NetworkError(error: NetworkingError.default)
            ).eraseToAnyPublisher()
        }
    )
    #endif
}

private extension DailyFxAPIProtocol {
    func requestDashboard() -> AnyPublisher<Dashboard, NetworkError<DiscardableResult>> {
        let subject = PassthroughSubject<Dashboard, NetworkError<DiscardableResult>>()

        requestDashboard { result in
            switch result {
            case let .success(model):
                subject.send(model)
                subject.send(completion: .finished)
            case let .failure(error):
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
}
