//
//  MovieVideoCell.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 03.06.2021.
//

import UIKit

class MovieVideoCell: UITableViewCell {
    static let identifier = "MovieVideo"
    
    private var videos = [Video]()
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
    }
    
    func configure(with movieVideos: [Video]) {
        videos = movieVideos
        
        videoCollectionView.reloadData()
    }
}

extension MovieVideoCell: UICollectionViewDelegate {
    
}

extension MovieVideoCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identificator, for: indexPath) as! VideoCollectionViewCell
        
        cell.configure(title: videos[indexPath.row].name, key: videos[indexPath.row].key)
        
        return cell
    }
    
}

extension MovieVideoCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
