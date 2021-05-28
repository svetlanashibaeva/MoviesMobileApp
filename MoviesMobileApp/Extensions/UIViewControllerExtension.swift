//
//  UIViewControllerExtension.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 28.05.2021.
//

import UIKit

extension UIViewController {
    func showError(error: String, handler: ((UIAlertAction) -> Void)? = nil) {
         let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
         let errorAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
         alertController.addAction(errorAction)

         present(alertController, animated: true, completion: nil)
     }
}

