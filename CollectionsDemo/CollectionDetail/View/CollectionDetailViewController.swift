//
//  CollectionDetailViewController.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/8.
//

import UIKit
import SDWebImage

protocol CollectionDetailViewControllerDelegate: AnyObject {
}

class CollectionDetailViewController: UIViewController {
    private enum Constants {
        static let nameFontSize: CGFloat = 20.0
        static let descriptionFontSize: CGFloat = 16.0
        static let openSeaButtonFontSize: CGFloat = 18.0
        static let cornerRadius: CGFloat = 8.0
        static let leadingTrailingOffset: CGFloat = 10.0
        static let labelLeadingTrailingOffset: CGFloat = 16.0
    }
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(
            ofSize: Constants.nameFontSize,
            weight: .bold
        )
        return label
    }()
    
    private let descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        textView.textAlignment = .center
        return textView
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 1
        ))
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var openseaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            "opensea",
            for: .normal
        )
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.openSeaButtonFontSize,
            weight: .bold
        )
        button.addTarget(
            self,
            action: #selector(openseaButtonTapped),
            for: .touchUpInside
        )
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = UIColor.systemTeal
        button.setTitleColor(
            UIColor.gray,
            for: .normal
        )
        
        
        return button
    }()
    
    private let viewModel: CollectionDetailViewModel
    
    init(viewModel: CollectionDetailViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAccessibilityIdentifiers()
        updateView()
    }
}

private extension CollectionDetailViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(dividerView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(openseaButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        openseaButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingTrailingOffset),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingTrailingOffset),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            dividerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingTrailingOffset),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingTrailingOffset),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            nameLabel.topAnchor.constraint(equalTo: dividerView.topAnchor, constant: Constants.leadingTrailingOffset),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelLeadingTrailingOffset),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.labelLeadingTrailingOffset),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelLeadingTrailingOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.labelLeadingTrailingOffset),
            descriptionLabel.bottomAnchor.constraint(equalTo: openseaButton.topAnchor, constant: -Constants.labelLeadingTrailingOffset),
            
            openseaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openseaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            openseaButton.widthAnchor.constraint(equalToConstant: 100),
            openseaButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        navigationItem.title = "Collection name"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    func setupAccessibilityIdentifiers() {
        imageView.accessibilityIdentifier = Accessibility.detailImageView
        nameLabel.accessibilityIdentifier = Accessibility.detailNameLabel
        descriptionLabel.accessibilityIdentifier = Accessibility.detailDescriptionLabel
        openseaButton.accessibilityIdentifier = Accessibility.detailOpenseaButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        navigationItem.title = viewModel.gallery.contractName
        if let urlString = viewModel.gallery.imageUrl {
            imageView.sd_setImage(with: URL(string: urlString))
        }
        nameLabel.text = viewModel.gallery.name
        descriptionLabel.text = viewModel.gallery.description
    }
    
    @objc func openseaButtonTapped() {
        guard let url = viewModel.inputs.getOpenseaLink() else {
            popErrorAlert()
            return
        }
        UIApplication.shared.open(
            url, options: [:],
            completionHandler: nil
        )
    }
    
    func popErrorAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Unable to open the OpenSea link.",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alertController.addAction(okAction)
        present(
            alertController,
            animated: true,
            completion: nil
        )
    }
}
