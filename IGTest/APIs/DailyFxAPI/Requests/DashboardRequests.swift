//
//  DashboardRequests.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 10/01/22.
//

import Foundation

typealias DashboardRequestCompletion = (Result<Dashboard, NetworkError<DiscardableResult>>) -> Void

extension DailyFxAPI {
    func requestDashboard(completion: @escaping DashboardRequestCompletion) {
        let endpoint = DashboardEndpoint.getDashboard()

        request(endpoint) { (
            response: HTTPURLResponse?,
            result: Result<Dashboard, NetworkError<DiscardableResult>>
        ) in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
