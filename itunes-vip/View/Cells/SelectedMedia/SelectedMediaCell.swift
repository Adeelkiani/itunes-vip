//
//  SelectedMedia.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import UIKit

class SelectedMediaCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var parentView: UIView!

    var removeTapped: (() -> Void)?
    
    var data: MediaTypePayload! {
        didSet {
            self.titleLabel.text = data.title ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        
        self.parentView.layer.cornerRadius = 3.0

        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 0.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    
    @IBAction func onRemoveMediaTapped(_ sender: Any) {
        removeTapped?()
    }
}
