//
//  SelectMediaTypeViewController.swift
//  Itunesvip
//
//  Created by Adeel kiani on 01/09/2022.
//

import UIKit

class SelectMediaTypeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellName = "MediaTypeCell"
    
    var coordinator: HomeCoordinatorDelegate!
    
    var mediaTypes: [String] = []
    var selectedMediaTypes: [String] = []
    var interactor: HomeInteractorDelegate?
    var handler: MediaTypesSelectionHandler?
    
    convenience init(mediaTypes: [String], selectedMediaTypes: [String], handler: @escaping MediaTypesSelectionHandler) {
        self.init()
        self.mediaTypes = mediaTypes
        self.selectedMediaTypes = selectedMediaTypes
        self.handler = handler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        self.coordinator.navigationController.navigationBar.isHidden = false
        
        // For title in navigation bar
        self.navigationItem.title = "Select Media Types"
        
        // For done button in navigation bar
        let logoutBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDonePressed))
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    @objc
    func onDonePressed() {
        self.handler?(self.selectedMediaTypes)
        self.coordinator.popViewController()
    }
}

extension SelectMediaTypeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? MediaTypeCell {
            
            cell.data = mediaTypes[indexPath.row]
            
            if selectedMediaTypes.contains(mediaTypes[indexPath.row]) {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: false)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = mediaTypes[indexPath.row]
        if !selectedMediaTypes.contains(item) {
            self.selectedMediaTypes.append(item)
        }
        
        self.interactor?.setSelectedMediaTypes(mediaTypes: self.selectedMediaTypes)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let item = mediaTypes[indexPath.row]
        self.selectedMediaTypes.removeAll(where: {$0 == item})
        self.interactor?.setSelectedMediaTypes(mediaTypes: self.selectedMediaTypes)
    }
}
