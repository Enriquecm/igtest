//
//  ViewController.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 05/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addLabel(title: "ViewController")
    }
}

extension UIViewController {

    func addLabel(title: String) {
        view.backgroundColor = .white
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

