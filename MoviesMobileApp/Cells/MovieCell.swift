//
//  MovieCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 24.05.2021.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(with movies: MovieStruct) {
        
        titleLabel.text = movies.title
        ratingLabel.text = movies.voteAverage?.description
        setImage(imageURL: movies.imageURL)
    }
    
    private func setImage(imageURL: String?) {
        guard let imageURL = imageURL else {
            return
        }
        let url = URL(string: imageURL)
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: url,
                                    placeholder: UIImage(named: "default-image.jpg"))
    }
    
}
