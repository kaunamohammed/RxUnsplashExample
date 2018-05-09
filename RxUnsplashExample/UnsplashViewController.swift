//
//  UnsplashViewController.swift
//  RxUnsplashExample
//
//  Created by Kauna Mohammed on 08/05/2018.
//  Copyright © 2018 NytCompany. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class UnsplashViewController: UIViewController {
    
    let unsplashPosts: Results<UnsplashResults> = {
        let syncConfig = Realm.Configuration.init(syncConfiguration: SyncConfiguration(user: SyncUser.current!, realmURL: Constants.RealmConstants.REALMURL))
        let realm = try! Realm(configuration: syncConfig)
        return realm.objects(UnsplashResults.self)
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search github repos"
        return controller
    }()
    
    var dataController: DataController!
    
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .yellow
       
        tableView.dataSource = self
        setUpTableView()
        
        dataController = DataController(api: UnsplashClient())
        dataController.fetch(query: "girls")
        
        token = unsplashPosts.observe({ [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
                
            case .initial:
                tableView.reloadData()
                break
                
            case .update(_, _, let insertions, let modifications):
                
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                
                for row in modifications {
                    let indexPath = IndexPath(row: row, section: 0)
                    let posts = self?.unsplashPosts[indexPath.row]
                    if let cell = tableView.cellForRow(at: indexPath) as? UnsplashTableViewCell {
                        cell.configure(posts!)
                    } else {
                        print("cell not found for \(indexPath)")
                    }
                }
                
                tableView.endUpdates()
                break
                
            case .error(let error):
                print(error.localizedDescription)
                break
            }
            
        })
        
    }
    
    private lazy var query: Observable<String> = {
        return self.searchText
            .debounce(0.3, scheduler: MainScheduler.instance)
            .filter(self.filterQuery(containsLessCharactersThan: Constants.minimumCharacters))
    }()
    
    private func filterQuery(containsLessCharactersThan minimumCharacters: Int) -> (String) -> Bool {
        return { query in
            return query.count >= minimumCharacters
        }
    }
    
    private lazy var searchText: Observable<String> = {
        return searchController.searchBar.rx.text.orEmpty.asObservable().skip(1)
    }()
    
    func setUpNavigationBar() {
        
        title = "Search Unsplash Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func setUpTableView() {
        
        view.addSubview(tableView)
        tableView.register(UnsplashTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 200
        tableView.anchorTo(view)
        
    }

}

extension UnsplashViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unsplashPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UnsplashTableViewCell
        let posts = unsplashPosts[indexPath.row]
        cell.configure(posts)
        return cell
    }
    
    
}

extension UITableView {
    
    func anchorTo(_ view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
}
