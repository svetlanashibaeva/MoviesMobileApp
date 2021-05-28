//
//  MovieOverviewCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 27.05.2021.
//

import UIKit

class MovieOverviewCell: UITableViewCell {
    
    static let identifier = "MovieOverview"
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    func configure(with overview: String?) {
        overviewLabel.text = overview
    }
}
