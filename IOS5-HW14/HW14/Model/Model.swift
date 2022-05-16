//
//  Model.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 09.05.2022.
//

import UIKit

struct Albums {
    let firstLabel: String
    let imageName: String
    let secondLabel: String

    enum SectionType {
        case collection(model: [Albums])
        case tableCells(model: Albums)
    }
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

struct Section {
    let sectionNumber: Int
    let sectionType: String
    let options: [Albums.SectionType]
}

