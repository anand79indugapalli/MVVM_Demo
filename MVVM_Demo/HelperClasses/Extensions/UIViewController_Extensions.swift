//
//  UIViewController_Extensions.swift
//  MVVM_Demo
//
//  Created by sai anand on 19/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async { [unowned self] in
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showProgressHub() {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading.."
    }

    func hideProgressHub() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

}

