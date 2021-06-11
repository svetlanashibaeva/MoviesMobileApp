//
//  SortByCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 07.06.2021.
//

import UIKit

class SortByCell: UITableViewCell {
    static let identifier = "Sort by Cell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortBySegmentedControll: UISegmentedControl!
    
    private var sortBy: SortBy = .popularity
    
    @IBAction func segmentedControlChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sortBy = .popularity
        case 1:
            sortBy = .voteAverage
        case 2:
            sortBy = .releaseDate
        default:
            break
        }
    }
}

extension SortByCell: FiltersProtocol {
    func getFilter() -> Filter {
        return .sortBy(by: sortBy.rawValue)
    }
}
