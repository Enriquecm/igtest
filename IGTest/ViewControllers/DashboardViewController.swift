//
//  DashboardViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class DashboardViewController: UISplitViewController {

    private unowned let coordinator: DashboardCoordinatorProtocol

    init(coordinator: DashboardCoordinatorProtocol) {

        self.coordinator = coordinator
        if #available(iOS 14.0, *) {
            super.init(style: .doubleColumn)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        edgesForExtendedLayout = []
        preferredDisplayMode = .allVisible

        if #available(iOS 14.0, *) {
            preferredSplitBehavior = .tile
        }
    }
}
