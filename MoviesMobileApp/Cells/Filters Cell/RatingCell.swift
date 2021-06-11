//
//  RatingCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 08.06.2021.
//

import UIKit

class RatingCell: UITableViewCell {
    static let identifier = "Rating Cell"

    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        let step: Float = 0.1
        let currentValue = round(sender.value / step) * step
        sender.value = currentValue
        ratingValueLabel.text = String(format: "%.1f", currentValue)
    }
}

extension RatingCell: FiltersProtocol {
    func getFilter() -> Filter {
        return .rating(by: ratingValueLabel.text ?? "0.0")
    }
}
