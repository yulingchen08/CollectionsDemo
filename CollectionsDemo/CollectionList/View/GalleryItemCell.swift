//
//  GalleryItemCell.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit
import SDWebImage


class GalleryItemCell: UICollectionViewCell {
    private enum Constants {
        static let borderWidth: CGFloat = 1.0
        static let borderCornerRadius: CGFloat = 8.0
        static let imageHeight: CGFloat = 150
        static let collapsedHeightOffset: CGFloat = 5
    }
    
    private let borderView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAccessibilityIdentifiers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(borderView)
        borderView.addSubview(imageView)
        borderView.addSubview(nameLabel)
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: borderView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            nameLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: borderView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: borderView.bottomAnchor)
        ])
    }
    
    private func setupAccessibilityIdentifiers() {
        imageView.accessibilityIdentifier = Accessibility.galleryImageView
        nameLabel.accessibilityIdentifier = Accessibility.galleryNameLabel
    }

    func configure(with item: Gallery) {
        borderView.layer.cornerRadius = Constants.borderCornerRadius
        if let urlString = item.imageUrl {
            imageView.sd_setImage(with: URL(string: urlString))
        }
        nameLabel.text = item.name
    }
}

