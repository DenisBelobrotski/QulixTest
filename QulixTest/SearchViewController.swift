//
//  SearchViewController.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 04.02.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var query: String? {
        didSet {
            gifsContainer?.reset()
            gifsContainer?.loadNextPage(query: query)
            self.title = query
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifsContainer = GifsContainer(collectionView: collectionView)
        gifsContainer?.loadNextPage(query: query)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let trendingGifsContainer = gifsContainer {
            if indexPath.row == (trendingGifsContainer.count - 1 - nextPageOffset) {
                trendingGifsContainer.loadNextPage(query: query)
            }
        }
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
}
