//
//  TabBarController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class TabBarController: UITabBarController {

    private unowned let coordinator: TabCoordinatorProtocol

    init(coordinator: TabCoordinatorProtocol) {

        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        let topline = CALayer()
        topline.frame = CGRect(x: 0, y: 0, width: self.tabBar.frame.width, height: 1)
        topline.backgroundColor = UIColor.lightGray.cgColor
        self.tabBar.layer.addSublayer(topline)
    }
}
