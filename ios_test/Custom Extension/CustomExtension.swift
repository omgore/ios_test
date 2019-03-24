//
//  CustomExtension.swift
//  ios_test
//
//  Created by Om Gore on 07/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

/**
 This extension is used for adding global activity indicator
 */

extension UIViewController {

    var activityIndicatorTag: Int { return 999999 }

    func startActivityIndicator(
        style: UIActivityIndicatorView.Style = .whiteLarge,
        location: CGPoint? = nil) {

        let loc = location ?? view.center

        DispatchQueue.main.async {

            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.color = UIColor.black
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }

    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter({
                $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }

    func isActivityIndicatorAnimating() -> Bool {
        if let activityIndicator = view.subviews.filter({
            $0.tag == activityIndicatorTag}).first as? UIActivityIndicatorView {
            return activityIndicator.isAnimating
        }
        return false
    }
}
