//
//  Model.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 09.05.2022.
//

import UIKit

struct AlbumsCollectionCell {
    let firstLabel: String
    let imageName: String
    let secondLabel: String
}

struct CategoryTableCell {
    let iconName: String
    let firstLabel: String
    let secondLabel: String
}

enum SectionType {
    case collection(models: [AlbumsCollectionCell], rows: CGFloat)
    case tableCells(models: [CategoryTableCell])
}

//struct Options {
//    let firstLabel: String
//    let iconName: String
//    let numberOfFoto: String
//}
//
//enum SectionType {
//    case collection(model: [Albums])
//    case tableCell(model: Options)
//}


