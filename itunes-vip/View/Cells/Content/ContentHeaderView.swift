//
//  ContentHeaderView.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import UIKit

class ContentHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    var data: String! {
        didSet {
            titleLabel.text = data
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
