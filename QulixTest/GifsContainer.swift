//
//  TrendingGifsManager.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 04.02.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit
import Alamofire

class GifsContainer {
    
    let limit: Int
    let rating: String
    let url: String = "https://api.giphy.com/v1/gifs/"
    let apiKey = "dc6zaTOxFJmzC"
    
    var gifs: [[String: Any]] = [[String: Any]]()
    var collectionView: UICollectionView?
    var query: String? = nil
    
    init(collectionView: UICollectionView?, limit: Int = 20, rating: String = "pg") {
        self.limit = limit
        self.rating = rating
        self.collectionView = collectionView
    }
    
    func loadNextPage(query: String? = nil) {
        var urlRequest = url
        if let query = query {
            urlRequest += "search?q=\(query)&"
        } else {
            urlRequest += "trending?"
        }
        urlRequest += "limit=\(limit)&offset=\(gifs.count)&rating=\(rating)&api_key=\(apiKey)"
//        print(urlRequest)
        loadGifs(urlRequest: urlRequest)
    }
    
    private func loadGifs(urlRequest: String) {
        Alamofire.request(urlRequest).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let pagination = responseValue["pagination"] as! [String: Any]? {
                    let responseGifsCount = (pagination["count"] as? Int) ?? 0
                    
                    //                    print((pagination["total_count"] as? Int) ?? 0)
                    //                    print((pagination["count"] as? Int) ?? 0)
                    //                    print((pagination["offset"] as? Int) ?? 0)
                    //                    print()
                    
                    if responseGifsCount != 0 {
                        if let responseGifs = responseValue["data"] as! [[String: Any]]? {
                            let indexPaths = self.getIndexPaths(offset: self.gifs.count, limit: self.limit)
                            self.gifs += responseGifs
                            self.collectionView?.insertItems(at: indexPaths)
                        }
                    }
                }
            }
        }
    }
    
    func fillCell(_ cell: GifCollectionViewCell, atIndexPath indexPath: IndexPath) {
        if self.gifs.count > 0 {
            let currentGif = self.gifs[indexPath.row]
//            print((currentGif["trending_datetime"] as? String) ?? "")
//            print((currentGif["rating"] as? String) ?? "")
            cell.labelGifName.text = (currentGif["title"] as? String) ?? ""
            if let images = currentGif["images"] as! [String: Any]? {
                if let image = images["fixed_width"] as! [String: Any]? {
//                    print((image["width"] as? String) ?? "")
//                    print((image["height"] as? String) ?? "")
                    if let gifUrl = image["url"] as? String {
                        DispatchQueue.global().async {
                            let gif = UIImage.gif(url: gifUrl)
                            DispatchQueue.main.async {
                                cell.imageView.image = gif
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getIndexPaths(offset: Int, limit: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for i in 0 ..< limit {
            indexPaths.append(IndexPath(row: offset + i, section: 0))
        }
        return indexPaths
    }

}
