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
    
    private var selectedGenres = [Genre]()
    
    func configure(genres: [Genre]) {
        selectedGenres = genres
        let text = genres.map({ $0.name.capitalized })
                              .joined(separator: ", ")
        
        genreNameLabel.text = text.isEmpty ? "любые" : text
    }
}

extension SelectGenresCell: FiltersProtocol {
    func getFilter() -> Filter {
        return .genres(by: selectedGenres)
    }
}
