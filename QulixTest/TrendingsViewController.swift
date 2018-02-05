//
//  ViewController.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 31.01.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit

class TrendingsViewController: BaseViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    // MARK: - Properties
    
    var searchViewController: SearchViewController = SearchViewController()
    var searchNavigationController: UINavigationController?
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        gifsContainer = GifsContainer(baseViewController: self)
        gifsContainer?.loadNextPage()
        
        searchNavigationController = UINavigationController(rootViewController: searchViewController)
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewController.query = searchController.searchBar.text
        present(searchNavigationController!, animated:true, completion: nil)
    }
    
}
