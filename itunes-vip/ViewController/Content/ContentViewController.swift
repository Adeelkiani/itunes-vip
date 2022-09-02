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

protocol ContentViewDelegate {
    func contentLoaded(sectionHeaders: [String], content: [String: [ContentPayload]])
}

class ContentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: ContentCoordinatorDelegate!
    var interactor: ContentInteractorDelegate?
    
    var viewType: ViewType = .GRID
    var sectionHeaders: [String] = []
    var contentList: [String: [ContentPayload]] = [:]
    let listCellName = "ListContentCell"
    let gridCellName = "GridContentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.interactor?.loadContent()
        
    }
    
    private func setupView() {
        
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: listCellName, bundle: nil), forCellReuseIdentifier: listCellName)
        tableView.register(UINib(nibName: gridCellName, bundle: nil), forCellReuseIdentifier: gridCellName)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        self.coordinator.navigationController.navigationBar.isHidden = false
        
        let barHeight = self.coordinator.navigationController.navigationBar.frame.size.height
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "itunes_template")
        
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    @IBAction func onLayoutChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewType = .GRID
        case 1:
            self.viewType = .LIST
        default: break
        }
        
        self.tableView.reloadData()
    }
}

extension ContentViewController: ContentViewDelegate {
    
    func contentLoaded(sectionHeaders: [String], content: [String: [ContentPayload]]) {
        self.sectionHeaders = sectionHeaders
        self.contentList = content
        self.tableView.reloadData()
    }
}

extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderLabelView = UIView()
        sectionHeaderLabelView.backgroundColor = UIColor(named: Colors.SectionHeader.rawValue)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.text = sectionHeaders[section]
        sectionHeaderLabel.textColor = .black
        sectionHeaderLabel.font = Fonts.font(fontWeight: .bold, fontSize: 18)
        sectionHeaderLabel.frame = CGRect(x: 10, y: 5, width: 250, height: 40)
        sectionHeaderLabelView.addSubview(sectionHeaderLabel)
        
        return sectionHeaderLabelView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch viewType {
        case .LIST:
            return 120
        case .GRID:
            return 200
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sectionHeaders[section]
        return contentList[sectionKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewType {
        case .LIST:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: listCellName, for: indexPath) as? ListContentCell {
                
                let sectionKey = sectionHeaders[indexPath.section]
                if let data = contentList[sectionKey]?[indexPath.row] {
                    cell.data = (sectionKey, data)
                }
                
                return cell
            }
            
        case .GRID:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: gridCellName, for: indexPath) as? GridContentCell {
                
                let sectionKey = sectionHeaders[indexPath.section]
                if let data = contentList[sectionKey]?[indexPath.row] {
                    cell.data = (sectionKey, data)
                }
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
