//
//  GenreNameCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 08.06.2021.
//

import UIKit

class GenreNameCell: UITableViewCell {
    static let identifier = "Name genre"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    func configure(with genre: Genre, isSelected: Bool) {
        nameLabel.text = genre.name
        checkImage.isHidden = !isSelected
    }
}
