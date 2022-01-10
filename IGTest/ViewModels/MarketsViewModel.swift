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

    func fetchDashboard() {
        dataSource.requestMarkets()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    break
                case .finished:
                    break
                }
            }, receiveValue: { dashboard in

            })
            .store(in: &cancellables)
    }
}
