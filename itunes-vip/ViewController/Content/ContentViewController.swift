//
//  ContentViewController.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import UIKit

enum ViewType {
    case GRID
    case LIST
}

protocol ContentViewDelegate: AnyObject {
    func contentLoaded(sectionHeaders: [String], content: [String: [ContentPayload]])
}

class ContentViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var coordinator: ContentCoordinatorDelegate!
    var interactor: ContentInteractorDelegate?
    
    var viewType: ViewType = .GRID
    var sectionHeaders: [String] = []
    var contentList: [String: [ContentPayload]] = [:]
    
    let contentHeaderName = "ContentHeaderView"
    let listCellName = "ListContentCell"
    let gridCellName = "GridContentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadContent()
    }
    
    private func setupView() {
        
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: contentHeaderName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: contentHeaderName)
        collectionView.register(UINib(nibName: listCellName, bundle: nil), forCellWithReuseIdentifier: listCellName)
        collectionView.register(UINib(nibName: gridCellName, bundle: nil), forCellWithReuseIdentifier: gridCellName)
        collectionView.reloadData()
    }
    
    private func setupNavigationBar() {
        self.coordinator.navigationController.navigationBar.isHidden = false
        
        let barHeight = self.coordinator.navigationController.navigationBar.frame.size.height
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "itunes_template")
        
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    func loadContent() {
        self.interactor?.loadContent()
    }
    
    @IBAction func onLayoutChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewType = .GRID
        case 1:
            self.viewType = .LIST
        default: break
        }
        
        self.collectionView.reloadData()
    }
}

extension ContentViewController: ContentViewDelegate {
    
    func contentLoaded(sectionHeaders: [String], content: [String: [ContentPayload]]) {
        self.sectionHeaders = sectionHeaders
        self.contentList = content
        self.collectionView.reloadData()
    }
}

extension ContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: "\(ContentHeaderView.self)", for: indexPath)
            
            guard let headerView = headerView as? ContentHeaderView
                    
            else { return headerView }
            
            let content = sectionHeaders[indexPath.section]
            headerView.data = content
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionHeaders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionKey = sectionHeaders[section]
        return contentList[sectionKey]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch viewType {
        case .LIST:
            return CGSize(width: self.collectionView.frame.width, height: 120)
        case .GRID:
            
            let lay = collectionViewLayout as? UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 3 - (lay?.minimumInteritemSpacing ?? 10.0)
            
            return CGSize(width: widthPerItem, height: 180)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewType {
        case .LIST:
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellName, for: indexPath) as? ListContentCell {
                
                let sectionKey = sectionHeaders[indexPath.section]
                if let data = contentList[sectionKey]?[indexPath.row] {
                    cell.data = (sectionKey, data)
                }
                
                return cell
            }
            
        case .GRID:
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellName, for: indexPath) as? GridContentCell {
                
                let sectionKey = sectionHeaders[indexPath.section]
                if let data = contentList[sectionKey]?[indexPath.row] {
                    cell.data = (sectionKey, data)
                }
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionKey = sectionHeaders[indexPath.section]
        if let data = contentList[sectionKey]?[indexPath.row], let mediaType = MEDIA_TYPE(rawValue: sectionKey) {
            
            if mediaType != .Artist {
            self.coordinator.navigateToDetails(mediaType: mediaType, content: data)
            } else {
                showAlert(message: "No additional details to be displayed")
            }
        }
    }
}
