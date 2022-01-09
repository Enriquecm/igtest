//
//  ArticlesViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class ArticlesViewController: UIViewController {

    private unowned let coordinator: ArticlesCoordinatorProtocol

    init(coordinator: ArticlesCoordinatorProtocol) {

        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
    }

    func addButton() {
        let button = UIButton()
        button.setTitle("ArticlesViewController", for: .normal)
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc
    func buttonSelected() {
        coordinator.didSelectButton()
    }
}

extension ArticlesViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let navigationController = secondaryViewController as? UINavigationController,
            navigationController.topViewController is ArticleDetailViewController {
            return true
        } else {
            return false
        }
    }

    @available(iOS 14.0, *)
    func splitViewController(
        _ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        return .primary
    }
}
