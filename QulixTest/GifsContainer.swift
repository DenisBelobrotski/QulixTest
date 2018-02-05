import UIKit
import Alamofire

class GifsContainer {
    
    // MARK: - Properties
    
    private let limit: Int
    private let rating: String
    private let url: String = "https://api.giphy.com/v1/gifs/"
    private let apiKey = "dc6zaTOxFJmzC"
    private let trendedGifDenotement = "This gif was in trendings"
    
    private var gifs = [[String: Any]]()
    private var query: String? = nil
    private var baseViewController: BaseViewController
    
    var count: Int {
        return gifs.count
    }
    
    
    // MARK: - Initialization
    
    init(baseViewController: BaseViewController, limit: Int = 20, rating: String = "pg") {
        self.limit = limit
        self.rating = rating
        self.baseViewController = baseViewController
    }
    
    
    // MARK: - Internal methods
    
    func loadNextPage(query: String? = nil) {
        var urlRequest = url
        if let query = query {
            urlRequest += "search?q=\(query)&"
        } else {
            urlRequest += "trending?"
        }
        urlRequest += "limit=\(limit)&offset=\(gifs.count)&rating=\(rating)&api_key=\(apiKey)"
        loadGifs(urlRequest: urlRequest)
    }
    
    func fillCell(_ cell: GifCollectionViewCell, atIndexPath indexPath: IndexPath) {
        if self.gifs.count > 0 {
            let currentGif = self.gifs[indexPath.row]
            if let trendingDatetime = currentGif["trending_datetime"] as? String {
                if trendingDatetime != "" && trendingDatetime != "0000-00-00 00:00:00" && trendingDatetime != "1970-01-01 00:00:00" {
                    cell.labelTrendedGif.text = trendedGifDenotement
                } else {
                    cell.labelTrendedGif.text = ""
                }
            }
            if let images = currentGif["images"] as! [String: Any]? {
                if let image = images["fixed_width"] as! [String: Any]? {
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
    
    func reset() {
        query = nil
        gifs = [[String: Any]]()
        baseViewController.collectionView?.reloadData()
    }
    
    
    // MARK: - Private methods
    
    private func loadGifs(urlRequest: String) {
        Alamofire.request(urlRequest).validate().responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let responseValue = response.result.value as! [String: Any]? {
                    if let pagination = responseValue["pagination"] as! [String: Any]? {
                        let responseGifsCount = (pagination["count"] as? Int) ?? 0
                        if responseGifsCount != 0 {
                            if let responseGifs = responseValue["data"] as! [[String: Any]]? {
                                let indexPaths = self.getIndexPaths(offset: self.gifs.count, limit: self.limit)
                                self.gifs += responseGifs
                                self.baseViewController.collectionView?.insertItems(at: indexPaths)
                            }
                        }
                    }
                }
            case .failure(_):
                self.baseViewController.showInternetConnectionErrorMessage()
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
