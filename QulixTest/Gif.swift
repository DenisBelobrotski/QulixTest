//
//  Gif.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 02.02.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import Foundation
import UIKit

struct Gif {
    var name: String?
    var imageURL: String?
}

var data: [Gif] = [
    Gif(name: "featured1", imageURL: "https://www.google.ru/doodle4google/images/splashes/featured.png"),
    Gif(name: "featured2", imageURL: "https://tehnot.com/wp-content/uploads/2017/10/1200px-Google_2015_logo.svg_-768x260.png"),
    Gif(name: "featured3", imageURL: "https://www.google.ru/doodle4google/images/splashes/featured.png"),
    Gif(name: "featured4", imageURL: "https://tehnot.com/wp-content/uploads/2017/10/1200px-Google_2015_logo.svg_-768x260.png"),
    Gif(name: "featured5", imageURL: "https://www.google.ru/doodle4google/images/splashes/featured.png"),
    Gif(name: "featured6", imageURL: "https://tehnot.com/wp-content/uploads/2017/10/1200px-Google_2015_logo.svg_-768x260.png"),
    Gif(name: "featured7", imageURL: "https://www.google.ru/doodle4google/images/splashes/featured.png"),
    Gif(name: "featured8", imageURL: "https://tehnot.com/wp-content/uploads/2017/10/1200px-Google_2015_logo.svg_-768x260.png"),
    Gif(name: "featured9", imageURL: "https://www.google.ru/doodle4google/images/splashes/featured.png"),
    Gif(name: "featured10", imageURL: "https://tehnot.com/wp-content/uploads/2017/10/1200px-Google_2015_logo.svg_-768x260.png")
]

extension UIImageView {
    public func getImageFromURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.image = UIImage(data: data!)
            })
        }).resume()
    }
}
