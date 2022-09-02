//
//  HomeViewController.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import UIKit

protocol HomeViewDelegate {
    func setMediaTypes(mediaTypes: [MediaTypePayload])
    func setSelectedMediaTypes(mediaTypes: [MediaTypePayload])
    func setEmptyMediaView()
    func contentDidLoaded(content: [String: [ContentPayload]])
    func contentDidFailed(error: String)

}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    var coordinator: HomeCoordinatorDelegate!
    var interactor: HomeInteractorDelegate?
    
    var mediaTypes: [MediaTypePayload] = []
    var selectedMediaTypes: [MediaTypePayload] = []
    
    let cellName = "SelectedMediaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        interactor?.loadMediaTypes()
        
    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }
    
    private func validate() -> Bool {
        if !searchField.hasText {
            self.showAlert(message: "Search field cannot be empty")
           return false
        }
        
        if selectedMediaTypes.isEmpty {
            self.showAlert(message: "Please select at least one mediaType")
            return false
        }
        return true
    }

    @IBAction func onAddMediaTypeTapped(_ sender: UITapGestureRecognizer) {
        
        self.coordinator.navigateToSelectMediaTypes(mediaTypes: mediaTypes, selectedMediaTypes: selectedMediaTypes) { [weak self] mediaTypes in
            
            self?.interactor?.setSelectedMediaTypes(mediaTypes: mediaTypes)
        }
    }
    
    @IBAction func onSubmitTapped(_ sender: Any) {
        if validate() {
            self.showLoader(text: "Loading content...")
            self.interactor?.fetchContent(searchQuery: searchField.text ?? "")
        }
    }
}

extension HomeViewController: HomeViewDelegate {
   
    func setMediaTypes(mediaTypes: [MediaTypePayload]) {
        self.mediaTypes = mediaTypes
    }
    
    func setSelectedMediaTypes(mediaTypes: [MediaTypePayload]) {
        self.selectedMediaTypes = mediaTypes
        if !mediaTypes.isEmpty {
            collectionView.backgroundColor = .white
            messageLabel.isHidden = true
        }
        self.collectionView.reloadData()
    }
    
    func setEmptyMediaView() {
        self.selectedMediaTypes.removeAll()
        collectionView.backgroundColor = UIColor(named: "EmptyCollectionView")
        messageLabel.isHidden = false
        self.collectionView.reloadData()
    }
    
    func contentDidLoaded(content: [String: [ContentPayload]]) {
        self.hideLoader { [weak self] in
            self?.coordinator.navigateToContent(content: content)
        }
    }
    
    func contentDidFailed(error: String) {
        self.hideLoader { [weak self] in
            self?.showAlert(title: "Error", message: error)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedMediaTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? SelectedMediaCell {
            
            cell.data = selectedMediaTypes[indexPath.row]
            cell.removeTapped = { [weak self] in
                if let type = self?.selectedMediaTypes[indexPath.row] {
                    self?.interactor?.removeSelectedMedia(type: type)
                }
            }
            return cell
            
        }
        return UICollectionViewCell()
    }
}
