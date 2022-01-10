//
//  MarketsCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol MarketsCoordinatorProtocol: AnyObject { }

class MarketsCoordinator: Coordinator, MarketsCoordinatorProtocol {
    private var navigationController: UINavigationController
    private let api: DailyFxAPIProtocol

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController, api: DailyFxAPIProtocol) {
        self.navigationController = navigationController
        self.api = api
    }

    func start() {
        navigateToMarkets()
    }
}

private extension MarketsCoordinator {
    func navigateToMarkets() {
        let viewModel = MarketsViewModel(coordinator: self, dataSource: .live(api: api))
        let viewController = MarketsViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
