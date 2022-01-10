//
//  ArticlesViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Combine
import Foundation

class ArticlesViewModel {
    private var cancellables = Set<AnyCancellable>()

    private weak var coordinator: ArticlesCoordinatorProtocol?
    private let dataSource: DashboardDataSource

    init(coordinator: ArticlesCoordinatorProtocol, dataSource: DashboardDataSource) {
        self.coordinator = coordinator
        self.dataSource = dataSource
    }

    func fetchDashboard() {
        dataSource.requestDashboard()
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
