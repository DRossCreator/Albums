//
//  AlbumsTableViewCell.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 09.05.2022.
//

import UIKit

protocol AlbumsTableViewCellDelegate: AnyObject {
    func didSelectItems(with model: AlbumsCollectionCell)
}

class AlbumsTableViewCell: UITableViewCell {

    public weak var delegate: AlbumsTableViewCellDelegate?

    static let identifier = "AlbumsTableViewCell"
    private var albums = [AlbumsCollectionCell]()

    //MARK: Views

    @IBOutlet var albumCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        settingsCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    //MARK: - Functions

    private func settingsCollectionView() {
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self

        albumCollectionView.register(
            AlbumCollectionViewCell.nib(),
            forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier
        )
    }

    public func configure(with models: [AlbumsCollectionCell]) {
        self.albums = models
        albumCollectionView.reloadData()
    }

    static func nib() -> UINib {
        return UINib(nibName: "AlbumsTableViewCell", bundle: nil)
    }

}

//MARK: - Extensions

extension AlbumsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    enum Metric {
        static let collectionViewWidth = 190
        static let collectionViewHeight = 240
        static let topEdgeinsetForSection: CGFloat = 0
        static let leftEdgeinsetForSection: CGFloat = 20
        static let bottomEdgeinsetForSection: CGFloat = 30
        static let rightEdgeinsetForSection: CGFloat = 20
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as! AlbumCollectionViewCell
        cell.configure(with: albums[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Metric.collectionViewWidth, height: Metric.collectionViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Metric.topEdgeinsetForSection, left: Metric.leftEdgeinsetForSection, bottom: Metric.bottomEdgeinsetForSection, right: Metric.rightEdgeinsetForSection)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = albums[indexPath.row]
        delegate?.didSelectItems(with: model)
    }

}
