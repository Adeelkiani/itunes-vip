//
//  ContentDetailsViewController.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import UIKit
import AVFoundation

class ContentDetailsViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionPlaceHolderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var previewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var previewPlaceHolderLabel: UILabel!
    
    var coordinator: ContentCoordinatorDelegate!
    var content: ContentPayload!
    var mediaType: MEDIA_TYPE!
    var playerAV: AVPlayer!
    
    init(mediaType: MEDIA_TYPE, content: ContentPayload) {
        self.mediaType = mediaType
        self.content = content
        super.init(nibName: "ContentDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    private func setData() {
        
        setupNavigationBar(title: content.artistName ?? "")
        
        switch mediaType {
            
        case .Album:
            self.setTitle(text: content.collectionName ?? "")
            self.setDescription(text: content.shortDescription ?? "Not available")
            self.setImage(imgUrl: content.artworkUrl100 ?? "")
            self.setVideoPlayer(videourl: content.previewUrl)
            
        case .Artist:
            self.headerImageView.isHidden = true
            
        case .Book:
            self.setTitle(text: content.trackName ?? "")
            self.setDescription(text: content.description ?? "Not available")
            self.setVideoPlayer(videourl: content.previewUrl)
            self.setImage(imgUrl: content.artworkUrl100 ?? "")
            
        case.Movie, .MusicVideo, .Podcast, .Song:
            self.setTitle(text: content.trackName ?? "")
            self.setDescription(text: content.shortDescription ?? "Not available")
            self.setImage(imgUrl: content.artworkUrl100 ?? "")
            self.setVideoPlayer(videourl: content.previewUrl)
            
            if mediaType == .Song {
                previewPlaceHolderLabel.text = "Song"
                previewContainerHeight.constant = 0
            }
            
        default: break
        }
    }
    
    private func setTitle(text: String) {
        titleLabel.text = text
    }
    
    private func setDescription(text: String) {
        descriptionLabel.text = text
    }
    
    private func setImage(imgUrl: String) {
        
        if let imgUrl = URL(string: imgUrl) {
            headerImageView.load(url: imgUrl) {_ in }
        } else {
            headerImageView.image = #imageLiteral(resourceName: "no-picture")
        }
    }
    
    private func setVideoPlayer(videourl: String?) {
        
        guard let url = videourl else {
            print("No preview available")
            return
        }
        
        if let videoURL = URL(string: url) {
            
            previewView.isHidden = false
            playerAV = AVPlayer(url: videoURL)
            
            let playerLayerAV = AVPlayerLayer(player: playerAV)
            playerLayerAV.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(playerLayerAV)
            playerLayerAV.videoGravity = .resizeAspectFill
        }
    }
    
    @IBAction func playvideo(sender: AnyObject) {
        playerAV.play()
        
        // you can fatch when video ended
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animationDidFinish(_:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: playerAV.currentItem)
    }
    
    @objc
    func animationDidFinish(_ notification: NSNotification) {
        playerAV.seek(to: .zero)
        playerAV.play()
        playerAV.pause()
    }
    
    private func setupNavigationBar(title: String = "Content Details") {
        self.coordinator.navigationController.navigationBar.isHidden = false
        self.navigationItem.title = title
    }
}
