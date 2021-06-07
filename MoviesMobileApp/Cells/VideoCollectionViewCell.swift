//
//  VideoCollectionViewCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 04.06.2021.
//

import UIKit
import youtube_ios_player_helper

class VideoCollectionViewCell: UICollectionViewCell, YTPlayerViewDelegate {
    
    static let identificator = "VideoCollectionViewCell"
    
    private let playerView = YTPlayerView()
    private let labelName = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        playerView.delegate = self;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubviews()
        configureSubviews()
        setConstraints()
    }
      
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelName.text = nil
    }
    
    private func addSubviews() {
        self.addSubview(labelName)
        self.addSubview(playerView)
    }
    
    private func setConstraints() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                              
            labelName.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 8),
            labelName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func configureSubviews() {
        playerView.layer.masksToBounds = true
        
        labelName.textAlignment = .center
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func configure(title: String?, key: String?) {
        guard let key = key else {
            return
        }
        playerView.load(withVideoId: key)
        labelName.text = title
    }
    
}
