//
//  MediaTypeCell.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import UIKit

class MediaTypeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: MediaTypePayload! {
        didSet {
            self.titleLabel.text = data.title ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        accessoryType = selected ? .checkmark : .none

        // Configure the view for the selected state
    }
    
}
