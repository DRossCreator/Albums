//
//  ViewController.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 09.05.2022.
//

import UIKit

class ViewController: UIViewController {
    var models = [Section]()

    //MARK: - Views

    @IBOutlet weak var albumsTableView: UITableView!

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()
        fillingContent()
    }

    //MARK: - PrivateFunc

    private func tableViewConfigure() {

        albumsTableView.register(
            AlbumsTableViewCell.nib(),
            forCellReuseIdentifier: AlbumsTableViewCell.identifier
        )

        albumsTableView.register(
            CategoryTableViewCell.nib(),
            forCellReuseIdentifier: CategoryTableViewCell.identifier
        )

        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }

    ///Adding sections with content to the array of sections.
    private func fillingContent() {
        models.append(Section(sectionNumber: 1, sectionType: "My Albums", options: [
            .collection(model: [
                Albums(firstLabel: "Recents", imageName: "image_01", secondLabel: "5"),
                Albums(firstLabel: "Instagram", imageName: "image_02", secondLabel: "20"),
                Albums(firstLabel: "Lightroom", imageName: "image_03", secondLabel: "1"),
                Albums(firstLabel: "VK", imageName: "image_04", secondLabel: "15"),
                ]
        )]))

        models.append(Section(sectionNumber: 2, sectionType: "Shared Albums", options: [
            .collection(model: [
                Albums(firstLabel: "Recents", imageName: "image_01", secondLabel: "5"),
                Albums(firstLabel: "Instagram", imageName: "image_02", secondLabel: "20"),
                Albums(firstLabel: "Lightroom", imageName: "image_03", secondLabel: "1"),
                Albums(firstLabel: "VK", imageName: "image_04", secondLabel: "15"),
                ]
        )]))

        models.append(Section(sectionNumber: 3, sectionType: "Media Types", options: [
            .tableCells(model: Albums(firstLabel: "Videos", imageName: "video", secondLabel: "1")),
        ]))

        models.append(Section(sectionNumber: 4, sectionType:  "Utilities", options: [
            .tableCells(model: Albums(firstLabel: "Imports", imageName: "square.and.arrow.down", secondLabel: "3")),
        ]))
    }

}

//MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    enum Metric {
        static let numberOfRowsInSection = 1
        static let heightAlbumsCells: CGFloat = 270
        static let heightOptionsCells: CGFloat = 50
        static let heightForHeaderInSection: CGFloat = 50
        static let headerLabelFontSize: CGFloat = 21
        static let headerButtonTrailingAnchor: CGFloat = -20
        static let headerButtonWidth: CGFloat = 60
        static let headerLabelLeadingAnchor: CGFloat = 20
    }

    enum Strings {
        static let headerButtonTitle = "See All"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //если установить значение больше одного, то приложение крашится
        return Metric.numberOfRowsInSection

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]

        switch model.self {
        case .collection(let model):
            guard let cell = albumsTableView.dequeueReusableCell(
                withIdentifier: AlbumsTableViewCell.identifier,
                for: indexPath
            ) as? AlbumsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .tableCells(let model):
            guard let cell = albumsTableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.identifier,
                for: indexPath
            ) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = models[indexPath.section].sectionNumber

        switch section.self {
        case 1:
            return (Metric.heightAlbumsCells * 2) - 10
        case 2:
            return Metric.heightAlbumsCells
        default:
            return Metric.heightOptionsCells
        }

    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return Metric.heightForHeaderInSection
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()

        let sectionHeaderButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(Strings.headerButtonTitle, for: .normal)

            return button
        }()

        let sectionHeaderLabel: UILabel = {
            let myLabel = UILabel()

            myLabel.text = models[section].sectionType
            myLabel.textColor = .black
            myLabel.font = UIFont.boldSystemFont(ofSize: Metric.headerLabelFontSize)

            return myLabel
        }()

        sectionHeaderView.addSubview(sectionHeaderButton)
        sectionHeaderView.addSubview(sectionHeaderLabel)

        sectionHeaderButton.translatesAutoresizingMaskIntoConstraints = false
        sectionHeaderButton.trailingAnchor.constraint(equalTo: sectionHeaderView.trailingAnchor, constant: Metric.headerButtonTrailingAnchor).isActive = true
        sectionHeaderButton.widthAnchor.constraint(equalToConstant: Metric.headerButtonWidth).isActive = true
        sectionHeaderButton.heightAnchor.constraint(equalTo: sectionHeaderView.heightAnchor).isActive = true

        sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionHeaderLabel.leadingAnchor.constraint(equalTo: sectionHeaderView.leadingAnchor, constant: Metric.headerLabelLeadingAnchor).isActive = true
        sectionHeaderLabel.heightAnchor.constraint(equalTo: sectionHeaderView.heightAnchor).isActive = true
        sectionHeaderLabel.trailingAnchor.constraint(equalTo: sectionHeaderButton.leadingAnchor).isActive = true

        return sectionHeaderView
    }

}

