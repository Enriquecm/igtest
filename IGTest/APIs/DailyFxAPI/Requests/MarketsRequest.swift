//
//  MarketsRequest.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 10/01/22.
//

import Foundation

typealias MarketsRequestCompletion = (Result<Markets, NetworkError<DiscardableResult>>) -> Void

extension DailyFxAPIProtocol {
    func requestMarkets(completion: @escaping MarketsRequestCompletion) {
        let endpoint = MarketsEndpoint.getMarkets()

        request(endpoint) { (
            response: HTTPURLResponse?,
            result: Result<Markets, NetworkError<DiscardableResult>>
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
