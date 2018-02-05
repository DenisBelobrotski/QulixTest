//
//  ViewController.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 31.01.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class BaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    var gifsContainer: GifsContainer? = nil
    private let cellId = "GifCell"
    private let cellSpacing:CGFloat = 10
    let nextPageOffset = 6
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.navigationBar.barTintColor = .black
        //        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //        self.navigationController?.isNavigationBarHidden = true
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.backgroundColor = .black
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        
        collectionView?.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
//        trendingGifsContainer = GifsContainer(collectionView: collectionView)
//        trendingGifsContainer?.loadNextPage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifsContainer?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GifCollectionViewCell
        cell.autolayoutCell()
        if let trendingGifsContainer = gifsContainer {
            trendingGifsContainer.fillCell(cell, atIndexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        let height = width
        return CGSize(width: width, height: height)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let trendingGifsContainer = gifsContainer {
            if indexPath.row == (trendingGifsContainer.count - 1 - nextPageOffset) {
                trendingGifsContainer.loadNextPage()
            }
        }
    }
    
}

