import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageViewMultiplier: CGFloat = 0.9
    private let labelTrendedGifFontSize: CGFloat = 12
    
    private var stackView: UIStackView = UIStackView()
    var imageView: UIImageView = UIImageView()
    var labelTrendedGif: UILabel = UILabel()
    
    
    // MARK: - Internal methods
    
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
        
        labelTrendedGif.translatesAutoresizingMaskIntoConstraints = false
        labelTrendedGif.font = .italicSystemFont(ofSize: labelTrendedGifFontSize)
        labelTrendedGif.textColor = .lightGray
        stackView.addArrangedSubview(labelTrendedGif)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
    }
    
}
