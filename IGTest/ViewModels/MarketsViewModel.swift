//
//  MarketsViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Combine
import Foundation

class MarketsViewModel {
    private var cancellables = Set<AnyCancellable>()

    private weak var coordinator: MarketsCoordinatorProtocol?
    private let dataSource: MarketsDataSource

    init(coordinator: MarketsCoordinatorProtocol, dataSource: MarketsDataSource) {
        self.coordinator = coordinator
        self.dataSource = dataSource
    }

    func fetchMarkets() -> AnyPublisher<[MarketSection], BusinessError> {
        return dataSource.requestMarkets()
            .mapError { BusinessError.map($0) }
            .tryCompactMap { try self.process(markets: $0) }
            .mapError { BusinessError.map($0) }
            .eraseToAnyPublisher()
    }
}

extension MarketsViewModel {
    private func process(markets: Markets) throws -> [MarketSection] {
        var sections = [MarketSection]()

        // Currencies
        if let currencies = markets.currencies {
            sections.append(MarketSection(title: "Currencies", markets: currencies))
        }

        // Commodities
        if let commodities = markets.commodities {
            sections.append(MarketSection(title: "Commodities", markets: commodities))
        }

        // Indices
        if let indices = markets.indices {
            sections.append(MarketSection(title: "indices", markets: indices))
        }

        if sections.isEmpty {
            throw BusinessError.marketsNotFound
        } else {
            return sections
        }
    }
}
