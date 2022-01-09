//
//  ArticleDetailCoordinator.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

protocol ArticleDetailCoordinatorProtocol: AnyObject { }

class ArticleDetailCoordinator: Coordinator, ArticleDetailCoordinatorProtocol {
    private var navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }

    var childCoordinators = [Coordinator]()

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let articleDetailViewController = ArticleDetailViewController(coordinator: self)
        navigationController.viewControllers = [articleDetailViewController]
    }
}
