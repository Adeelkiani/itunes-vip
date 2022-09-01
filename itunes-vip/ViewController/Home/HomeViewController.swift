//
//  HomeViewController.swift
//  itunes-vip
//
//  Created by Adeel kiani on 31/08/2022.
//

import UIKit

protocol HomeViewDelegate {
    func setMediaTypes(mediaTypes: [String])
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    
    var coordinator: HomeCoordinatorDelegate!
    var interactor: HomeInteractorDelegate?
    
    var mediaTypes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.loadMediaTypes()
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SlidingContentViewCell", bundle: nil), forCellWithReuseIdentifier: "SlidingContentViewCell")
        collectionView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCell")
    }
    
    @IBAction func onSubmitTapped(_ sender: Any) {
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width - 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mediaTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidingContentViewCell", for: indexPath) as? SlidingContentViewCell {
        //
        //            cell.data = devicesList[indexPath.row]
        //
        //
        //            return cell
        //
        //        }
        return UICollectionViewCell()
        
    }
}
extension HomeViewController: HomeViewDelegate {
    func setMediaTypes(mediaTypes: [String]) {
        print("MEDIA TYPES: \(mediaTypes)")
    }
}
