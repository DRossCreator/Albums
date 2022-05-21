//
//  CategoryTableViewCell.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 12.05.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static let identifier = "CategoryTableViewCell"
    
    //MARK: - Views

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var numberOfPhotoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: - Functions

    ///substitution of values in a tableViewCell.
    public func configure(with model: CategoryTableCell) {
        self.categoryNameLabel.text = model.firstLabel
        self.categoryImageView.image = UIImage(systemName: model.iconName)
        self.numberOfPhotoLabel.text = model.secondLabel
    }

    static func nib() -> UINib {
        return UINib(nibName: "CategoryTableViewCell", bundle: nil)
    }
}
