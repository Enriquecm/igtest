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
        let marketsViewController = MarketsViewController(coordinator: self)
        navigationController.viewControllers = [marketsViewController]
    }
}
