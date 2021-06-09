//
//  RatingCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 08.06.2021.
//

import UIKit

class RatingCell: UITableViewCell {
    static let identifier = "Rating Cell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
}
