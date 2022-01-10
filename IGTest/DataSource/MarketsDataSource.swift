//
//  MarketsDataSource.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 10/01/22.
//

import Combine
import Foundation

struct MarketsDataSource {
    let requestMarkets: () -> AnyPublisher<Markets, NetworkError<DiscardableResult>>
}

extension MarketsDataSource {
    static func live(api: DailyFxAPIProtocol) -> MarketsDataSource {
        return MarketsDataSource(
            requestMarkets: { api.requestMarkets() }
        )
    }

    #if DEBUG
//    static let mock = MarketsDataSource(
//        requestMarkets: { _, _ in
//            CurrentValueSubject<Markets, NetworkError<DiscardableResult>>(Markets.mock).eraseToAnyPublisher()
//        }
//    )

    static let failed = MarketsDataSource(
        requestMarkets: {
            Fail<Markets, NetworkError<DiscardableResult>>(
                error: NetworkError(error: NetworkingError.default)
            ).eraseToAnyPublisher()
        }
    )
    #endif
}

private extension DailyFxAPIProtocol {
    func requestMarkets() -> AnyPublisher<Markets, NetworkError<DiscardableResult>> {
        let subject = PassthroughSubject<Markets, NetworkError<DiscardableResult>>()

        requestMarkets { result in
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
