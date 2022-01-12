//
//  UIViewControllerExtensions.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import UIKit

extension UIViewController {
    /// Show a simple `UIAlertController` with `cancel` style
    /// - Parameters:
    ///     - title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
    ///     - message: Descriptive text that provides additional details about the reason for the alert.
    ///     - alertTitle: The text to use for the button title. The value you specify should be localized for the user’s current language. Defaults to `Ok`
    ///     - style: The style to use when presenting the alert controller. Use this parameter to configure the alert controller as an action sheet or as a modal alert. Defaults to `.alert`
    func showSimpleAlert(
        _ title: String?,
        message: String?,
        alertTitle: String = "Ok",
        style: UIAlertController.Style = .alert
    ) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: style)
        refreshAlert.addAction(UIAlertAction(title: alertTitle, style: .cancel, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }
}
