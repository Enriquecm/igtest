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

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigateToMarkets()
    }
}

private extension MarketsCoordinator {
    func navigateToMarkets() {
        let viewModel = MarketsViewModel(coordinator: self)
        let viewController = MarketsViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
