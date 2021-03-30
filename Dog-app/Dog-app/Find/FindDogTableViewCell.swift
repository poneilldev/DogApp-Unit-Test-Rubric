//
//  FindDogTableViewCell.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/29/21.
//

import UIKit

class FindDogTableViewCell: UITableViewCell {
    static let identifier = "FindDogCollectionViewCell"
    static let cellHeight: CGFloat = 50
    
    let breedNameLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        breedNameLabel = UILabel()
        breedNameLabel.translatesAutoresizingMaskIntoConstraints = false

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(breedNameLabel)

        NSLayoutConstraint.activate([
            breedNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            breedNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            breedNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configureCell(_ breed: BreedProtocol?) {
        breedNameLabel.text = breed?.name ?? "-------"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
