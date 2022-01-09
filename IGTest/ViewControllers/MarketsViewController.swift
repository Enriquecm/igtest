//
//  MarketsViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 08/01/22.
//

import UIKit

class MarketsViewController: UIViewController {

    private unowned let coordinator: MarketsCoordinatorProtocol

    init(coordinator: MarketsCoordinatorProtocol) {

        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabel(title: "MarketsViewController")
    }
}
