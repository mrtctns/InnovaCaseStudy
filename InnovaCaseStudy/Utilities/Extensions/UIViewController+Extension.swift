//
//  UIViewController+Extension.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 13.07.2023.
//

import Foundation

extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
