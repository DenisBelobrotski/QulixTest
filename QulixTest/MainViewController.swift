//
//  ViewController.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 31.01.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView?
//    var gifs: [Gif] = data
    var gifs: [[String: Any]] = [[String: Any]]()
    let cellId = "GifCell"
    let cellSpacing:CGFloat = 10
    let mainTitle = "Trendings"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = mainTitle
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
        
        Alamofire.request("https://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=5&rating=pg").responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseGifs = responseValue["data"] as! [[String: Any]]? {
                    self.gifs = responseGifs
                    self.collectionView?.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gifs.count)
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GifCollectionViewCell
        cell.autolayoutCell()
        if self.gifs.count > 0 {
            let currentGif = self.gifs[indexPath.row]
            print((currentGif["title"] as? String) ?? "")
            print((currentGif["trending_datetime"] as? String) ?? "")
            print((currentGif["rating"] as? String) ?? "")
            cell.labelGifName.text = (currentGif["title"] as? String) ?? ""
            if let images = currentGif["images"] as! [String: Any]? {
                if let image = images["fixed_width"] as! [String: Any]? {
                    print((image["url"] as? String) ?? "")
                    print((image["width"] as? String) ?? "")
                    print((image["height"] as? String) ?? "")
                }
            }
        }
        
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        let height = width
        return CGSize(width: width, height: height)
    }


}
