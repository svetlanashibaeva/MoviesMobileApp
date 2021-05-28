//
//  MovieInfoCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 27.05.2021.
//

import UIKit

class MovieInfoCell: UITableViewCell {
    static let identifier = "MovieInfo"
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originalNameLabel: UILabel!
    @IBOutlet weak var datePremierLabel: UILabel!    
    @IBOutlet weak var genreLabel: UILabel!
    
    func configure(with movies: MovieDetail) {
        nameLabel.text = movies.title
        originalNameLabel.text = movies.originalTitle
        datePremierLabel.text = movies.releaseDate?.description
        genreLabel.text = movies.genre.joined(separator: " ")
        setImage(imageURL: movies.imageURL)
    }
    
    private func setImage(imageURL: String?) {
        guard let imageURL = imageURL else {
            return
        }
        let url = URL(string: imageURL)
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: url)
        movieImageView.kf.setImage(with: url,
                                    placeholder: UIImage(named: "default-image.jpg"))
    }
    
}
