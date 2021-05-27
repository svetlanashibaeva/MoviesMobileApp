//
//  FooterCollectionReusableView.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 26.05.2021.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "FooterCollectionReusableView"
    
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    public func configure() {
        backgroundColor = .white
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = bounds
    }
}
