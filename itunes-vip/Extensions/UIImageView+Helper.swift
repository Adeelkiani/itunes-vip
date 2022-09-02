//
//  UIImageView+Helper.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(url: URL, onResult: @escaping (_ isLoaded: Bool) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self?.image = image
                        onResult(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        onResult(false)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    onResult(false)
                }
            }
        }
    }
}
