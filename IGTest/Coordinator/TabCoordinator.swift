//
//  TabCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol TabCoordinatorProtocol: AnyObject { }

class TabCoordinator: Coordinator, TabCoordinatorProtocol {
    private var navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }
    
    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        setupUI()

        let tabBarController = TabBarController(coordinator: self)

        // Dashboard
        let dashboardCoordinator = DashboardCoordinator(navigationController)
        dashboardCoordinator.start()

        let dashboardRootViewController = dashboardCoordinator.rootViewController
        dashboardRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        // Markets
        let marketsNavigationController = UINavigationController()
        marketsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)

        let marketsCoordinator = MarketsCoordinator(marketsNavigationController)
        marketsCoordinator.start()

        tabBarController.viewControllers = [dashboardRootViewController,
                                            marketsNavigationController]

        navigationController.viewControllers = [tabBarController]

        childCoordinators.append(dashboardCoordinator)
        childCoordinators.append(marketsCoordinator)
    }

    private func setupUI() {
        navigationController.isNavigationBarHidden = true
    }
}
