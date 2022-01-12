//
//  UIViewExtensions.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import UIKit

extension UIView {
    func show(on viewContainer: UIView, isAnimated: Bool = true) {
        let size = viewContainer.sizeThatFits(frame.size)
        let xPosition = viewContainer.bounds.origin.x
        let yPosition = 0.0
        let viewFrame = CGRect(
            x: xPosition,
            y: yPosition,
            width: size.width,
            height: size.height
        )

        show(on: viewContainer, with: viewFrame, isAnimated: isAnimated)
    }

    func showFullScreen(isAnimated: Bool = true) {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let statusBarHeight = keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

        let fullScreenFrame = CGRect(
            x: 0,
            y: -statusBarHeight,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height + statusBarHeight
        )

        show(on: keyWindow, with: fullScreenFrame, isAnimated: isAnimated)
    }

    private func show(on viewContainer: UIView?,
                      with viewFrame: CGRect? = nil,
                      isAnimated: Bool = true) {
        if let viewFrame = viewFrame {
            frame = viewFrame
        }

        alpha = 1
        if isAnimated {
            alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.alpha = 1
            }
        }

        if viewContainer?.subviews.contains(self) == true {
            viewContainer?.bringSubviewToFront(self)
        } else {
            viewContainer?.addSubview(self)
        }
    }

    func removeView(isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        self.alpha = 1
        if isAnimated {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
                completion?()
            })
        } else {
            self.removeFromSuperview()
            completion?()
        }
    }

    func constraintToMatch(view: UIView, inset: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset.right),
            view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: inset.bottom)
        ])
    }

    func constraintToCenter(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
