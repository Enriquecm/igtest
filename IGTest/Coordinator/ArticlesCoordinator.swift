//
//  ArticlesCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol ArticlesCoordinatorProtocol: AnyObject {
    func didSelect(report: Report)
}

class ArticlesCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let api: DailyFxAPIProtocol

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    var dashboardCoordinator: DashboardCoordinatorProtocol?

    init(_ navigationController: UINavigationController, api: DailyFxAPIProtocol) {
        self.navigationController = navigationController
        self.api = api
    }

    func start() {
        navigateToArticles()
    }
}

private extension ArticlesCoordinator {
    func navigateToArticles() {
        let viewModel = ArticlesViewModel(coordinator: self, dataSource: .live(api: api))
        let viewController = ArticlesViewController(viewModel: viewModel)
        viewController.title = "Dashboard"
        navigationController.viewControllers = [viewController]
    }
}

extension ArticlesCoordinator: ArticlesCoordinatorProtocol {
    func didSelect(report: Report) {
        dashboardCoordinator?.didSelect(report: report)
    }
}
