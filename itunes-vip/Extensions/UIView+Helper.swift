//
//  UIView+Helper.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import UIKit

extension UIView {
   
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
}
