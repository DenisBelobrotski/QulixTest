//
//  GifCollectionViewCell.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 02.02.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    private let stackViewSpacing: CGFloat = 10
    private let imageViewMultiplier: CGFloat = 0.8
    private let labelGifNameFontSize: CGFloat = 15
    private var stackView: UIStackView = UIStackView()
    var imageView: UIImageView = UIImageView()
    var labelGifName: UILabel = UILabel()
    
    func autolayoutCell() {
        self.backgroundColor = .black
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: imageViewMultiplier).isActive = true
        
        labelGifName.translatesAutoresizingMaskIntoConstraints = false
        labelGifName.font = .boldSystemFont(ofSize: 15)
        labelGifName.textColor = .white
        stackView.addArrangedSubview(labelGifName)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = stackViewSpacing
    }
    
}
