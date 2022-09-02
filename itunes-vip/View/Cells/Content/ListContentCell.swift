//
//  ListContentCell.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import UIKit

class ListContentCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    
    var data: (mediaType: String, content: ContentPayload)! {
        didSet {
            if let imgUrl = URL(string: data.content.artworkUrl100 ?? "") {
                contentImage.load(url: imgUrl) { [weak self] _ in}
            }
            if let type = MediaTypes(rawValue: data.mediaType) {
                setTitle(type: type, content: data.content)
            }
        }
    }
    
    private func setTitle(type: MediaTypes, content: ContentPayload) {
        
        switch type {
        
        case .Album:
            titleLabel.text = content.collectionName ?? ""
            descriptionLabel.text = content.artistName ?? ""
        
        case .Artist, .Book, .Movie, .MusicVideo, .Podcast, .Song:
            titleLabel.text = content.trackName ?? ""
            descriptionLabel.text = content.artistName ?? ""
       
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
