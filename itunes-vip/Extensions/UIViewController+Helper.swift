//
//  UIViewController+Helper.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import Foundation
import UIKit
import ANLoader

extension UIViewController {
    
    func hideKeyboardWhenTappedAround(view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func hideKeyBoard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoader(text: String, disableUserInteraction: Bool = false, showDimView: Bool = false) {
        ANLoader.viewBackgroundDark = showDimView
        ANLoader.showLoading(text, disableUI: disableUserInteraction)
    }
    
    func hideLoader(delay: DispatchTime = .now() + 0.5, onLoaderHidden: @escaping () -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            ANLoader.hide()
            onLoaderHidden()
        }
    }
}
