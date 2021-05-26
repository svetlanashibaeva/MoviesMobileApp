//
//  MovieCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 24.05.2021.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    https://image.tmdb.org/t/p/w300////pMIixvHwsD5RZxbvgsDSNkpKy0R.jpg
    
    
    
    func configure(with movies: MovieStruct) {
        
        titleLabel.text = movies.title
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
