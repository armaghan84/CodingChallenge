//
//  UtilityFunctions.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation
import UIKit
class UtilityFunctions
{
    // MARK: - Alert 
    func showStandardAlert(title: String?, message: String?,viewController: UIViewController?)
    {
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController!.present(alert, animated: true, completion: nil)
    }
    // MARK: - Activity Indicator
    func addActivityIndicator(activityIndicator: UIActivityIndicatorView, viewController: UIViewController)
    {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
    }
    func startActivityIndicator(activityIndicator: UIActivityIndicatorView, viewController: UIViewController)
    {
        self.addActivityIndicator(activityIndicator: activityIndicator, viewController: viewController)
        activityIndicator.startAnimating()
    }
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView, viewController: UIViewController)
    {
        activityIndicator.stopAnimating()
    }
}
