//
//  AppCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class AppCoordinator: Coordinator {
    private var navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}
