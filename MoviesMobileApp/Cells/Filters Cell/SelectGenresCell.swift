//
//  SelectGenresCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 08.06.2021.
//

import UIKit

class SelectGenresCell: UITableViewCell {
    static let identifier = "Genre Cell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreNameLabel: UILabel!
    
    func configure(text: String) {
        genreNameLabel.text = text.isEmpty ? "любые" : text
    }
}
