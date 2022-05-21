//
//  ViewController.swift
//  HW14
//
//  Created by Daniil Yarkovenko on 09.05.2022.
//

import UIKit

class ViewController: UIViewController {
    var models = [SectionType]()

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

        albumsTableView.allowsSelection = true
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
    }

    ///Adding sections with content to the array of sections.
    private func fillingContent() {
        models.append(.collection(models: [
            AlbumsCollectionCell(firstLabel: "Recents", imageName: "image_01", secondLabel: "5"),
            AlbumsCollectionCell(firstLabel: "Instagram", imageName: "image_02", secondLabel: "20"),
            AlbumsCollectionCell(firstLabel: "Lightroom", imageName: "image_03", secondLabel: "1"),
            AlbumsCollectionCell(firstLabel: "VK", imageName: "image_04", secondLabel: "15"),
            ], rows: 2))


        models.append(.collection(models: [
            AlbumsCollectionCell(firstLabel: "Recents", imageName: "image_01", secondLabel: "5"),
            AlbumsCollectionCell(firstLabel: "Instagram", imageName: "image_02", secondLabel: "20"),
            AlbumsCollectionCell(firstLabel: "Lightroom", imageName: "image_03", secondLabel: "1"),
            AlbumsCollectionCell(firstLabel: "VK", imageName: "image_04", secondLabel: "15"),
            ], rows: 1))

        models.append(.tableCells(models: [
            CategoryTableCell(iconName: "video", firstLabel: "Videos", secondLabel: "1"),
            CategoryTableCell(iconName: "person.crop.square", firstLabel: "Selfies", secondLabel: "134"),
            CategoryTableCell(iconName: "cube", firstLabel: "Portrait", secondLabel: "3"),
            CategoryTableCell(iconName: "camera.viewfinder", firstLabel: "Screenshots", secondLabel: "20"),
            CategoryTableCell(iconName: "record.circle", firstLabel: "Screen Recording", secondLabel: "20"),
        ]))

        models.append(.tableCells(models: [
            CategoryTableCell(iconName: "square.and.arrow.down", firstLabel: "Imports", secondLabel: "4"),
            CategoryTableCell(iconName: "eye.slash", firstLabel: "Hidden", secondLabel: "18"),
            CategoryTableCell(iconName: "trash", firstLabel: "Recently Deleted", secondLabel: "41"),
        ]))
    }

}

//MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    enum Metric {
        static let numberOfRowsInSection = 1
        static let heightAlbumsCells: CGFloat = 265
        static let heightOptionsCells: CGFloat = 50
        static let heightForHeaderInSection: CGFloat = 50
        static let headerLabelFontSize: CGFloat = 21
        static let headerButtonTrailingAnchor: CGFloat = -20
        static let headerButtonWidth: CGFloat = 60
        static let headerLabelLeadingAnchor: CGFloat = 20
    }

    enum Strings {
        static let headerButtonTitle = "See All"
        static let firstHeader = "My Albums"
        static let secondHeader = "People & Places"
        static let thirdHeader = "Media Types"
        static let fourthHeader = "Utilities"

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .collection(_, _):
            return Metric.numberOfRowsInSection
        case .tableCells(let models):
            return models.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case .collection(let models, _):
            guard let cell = albumsTableView.dequeueReusableCell(
                withIdentifier: AlbumsTableViewCell.identifier,
                for: indexPath
            ) as? AlbumsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: models)
            return cell

        case .tableCells(let models):
            let model = models[indexPath.row]
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
        switch models[indexPath.section] {
        case .collection(_,let rows):
            return Metric.heightAlbumsCells * rows
        case .tableCells(_):
            return Metric.heightOptionsCells
        }

    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return Metric.heightForHeaderInSection
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumsTableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headers = [Strings.firstHeader, Strings.secondHeader, Strings.thirdHeader, Strings.fourthHeader]

        let sectionHeaderView = UIView()

        let sectionHeaderButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(Strings.headerButtonTitle, for: .normal)

            return button
        }()

        let sectionHeaderLabel: UILabel = {
            let myLabel = UILabel()

            myLabel.text = headers[section]
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

