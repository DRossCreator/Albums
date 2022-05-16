//
//  AlbumCollectionViewCell.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 09.05.2022.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumCollectionViewCell"

    //MARK: - Views

    @IBOutlet var albumLabel: UILabel!
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewConfigure()
    }

    //MARK: - Functions

    ///substitution of values in a collection cell
    public func configure(with model: Albums) {
        self.albumLabel.text = model.firstLabel
        self.albumImageView.image = UIImage(named: model.imageName)
        self.secondLabel.text = model.secondLabel
    }

    static func nib() -> UINib {
        return UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
    }

    private func imageViewConfigure() {
        albumImageView.layer.cornerRadius = 5
        albumImageView.layer.masksToBounds = true
    }
}
