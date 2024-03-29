//
//  CollectionListViewController.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/5.
//

import UIKit

protocol CollectionListViewControllerDelegate: AnyObject {
    func didClickCell(gallery: Gallery)
}

class CollectionListViewController: UIViewController {

    private enum Constants {
        static let cellId = "GalleryItemCell"
        static let cellHeight: CGFloat = 200.0
        static let interItemSpace: CGFloat = 8.0
        static let lineSpace: CGFloat = 16.0
        static let balanceFontSize: CGFloat = 8.0
    }
    weak var delegate: CollectionListViewControllerDelegate?
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GalleryItemCell.self, forCellWithReuseIdentifier: Constants.cellId)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private let viewModel: CollectionListViewModel

    init(viewModel: CollectionListViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupNavigationBar()
        setupAccessibilityIdentifiers()
        bindViewModel()
        viewModel.inputs.onViewDidLoad()
    }
}

private extension CollectionListViewController {
    func configureCollectionView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "main_list".localized
    }

    func setupAccessibilityIdentifiers() {
        collectionView.accessibilityIdentifier = Accessibility.listCollection
    }

    func updateBalance(_ balance: String?) {
        guard let balance else { return }
        let balanceLabel = UILabel()
        balanceLabel.text = "\("main_balance".localized): \(balance)"
        balanceLabel.textColor = UIColor.black
        balanceLabel.font = UIFont.systemFont(ofSize: Constants.balanceFontSize)
        balanceLabel.accessibilityIdentifier = Accessibility.balanceButton
        let balanceItem = UIBarButtonItem(customView: balanceLabel)
        navigationItem.rightBarButtonItem = balanceItem
    }

    func bindViewModel() {
        viewModel.outputs.presentCollectionCell = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.outputs.updateBalance = { [weak self] balance in
            DispatchQueue.main.async {
                self?.updateBalance(balance)
            }
        }
    }
}

extension CollectionListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.inputs.dataSource.galleries.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellId,
            for: indexPath
        ) as? GalleryItemCell else {
            return UICollectionViewCell()
        }

        let item = viewModel.inputs.dataSource.galleries[indexPath.item]
        cell.configure(with: item)

        return cell
    }
}

extension CollectionListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        delegate?.didClickCell(
            gallery: viewModel.inputs.dataSource.galleries[indexPath.row]
        )
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.inputs.dataSource.galleries.count - 1 {
            viewModel.inputs.fetchMoreCollections()
        }
    }
}

extension CollectionListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.bounds.width / 2 - Constants.lineSpace,
            height: Constants.cellHeight
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.interItemSpace
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.lineSpace
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 0,
            left: Constants.interItemSpace,
            bottom: 0,
            right: 8
        )
    }
}
