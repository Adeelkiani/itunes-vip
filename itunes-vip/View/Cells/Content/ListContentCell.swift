//
//  ListContentCell.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import UIKit

class ListContentCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    
    var data: (mediaType: String, content: ContentPayload)! {
        didSet {
            if let imgUrl = URL(string: data.content.artworkUrl100 ?? "") {
                contentImage.contentMode = .scaleAspectFill
                contentImage.load(url: imgUrl) {_ in}
            } else {
                contentImage.contentMode = .scaleAspectFit
                contentImage.image = #imageLiteral(resourceName: "no-picture")
            }
            
            if let type = MEDIA_TYPE(rawValue: data.mediaType) {
                setTitle(type: type, content: data.content)
            }
        }
    }
    
    private func setTitle(type: MEDIA_TYPE, content: ContentPayload) {
        
        switch type {
        
        case .Album:
            titleLabel.text = content.collectionName ?? ""
            descriptionLabel.text = content.artistName ?? ""
        
        case .Artist:
            titleLabel.text = content.artistName ?? ""
            descriptionLabel.text = content.primaryGenreName ?? ""
            
        case .Book, .Movie, .MusicVideo, .Podcast, .Song:
            titleLabel.text = content.trackName ?? ""
            descriptionLabel.text = content.artistName ?? ""
       
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
