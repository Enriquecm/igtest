//
//  ArticlesCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol ArticlesCoordinatorProtocol: AnyObject {
    func didSelectButton()
}

class ArticlesCoordinator: Coordinator {
    private var navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    var dashboardCoordinator: DashboardCoordinatorProtocol?

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let articlesViewController = ArticlesViewController(coordinator: self)
        navigationController.viewControllers = [articlesViewController]
    }
}

extension ArticlesCoordinator: ArticlesCoordinatorProtocol {
    func didSelectButton() {
        dashboardCoordinator?.didSelectButton()
    }
}
