//
//  AppCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
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
        navigateToTabBar()
    }
}

private extension AppCoordinator {
    func navigateToTabBar() {
        let tabCoordinator = TabCoordinator(navigationController, api: api)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}
