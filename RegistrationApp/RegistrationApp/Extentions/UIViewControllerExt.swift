//
//  UIViewControllerExt.swift
//  RegistrationApp
//
//  Created by Alexander Lobonenok on 7.08.22.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}

