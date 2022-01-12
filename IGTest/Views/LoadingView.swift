//
//  LoadingView.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import UIKit

class LoadingView: UIView {
    private let viewBackground = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    init() {
        super.init(frame: .zero)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupUI()
        setupIndicator()
    }

    private func setupUI() {
        addSubview(viewBackground)
        addSubview(activityIndicator)

        viewBackground.constraintToMatch(view: self)
        activityIndicator.constraintToCenter(to: self)
    }

    private func setupIndicator() {
        viewBackground.backgroundColor = .black.withAlphaComponent(0.3)
        activityIndicator.startAnimating()
    }
}

extension LoadingView: LoadingProtocol {
    func startLoading() {
        DispatchQueue.main.async {
            self.showFullScreen(isAnimated: true)
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.removeView(isAnimated: true)
        }
    }
}
