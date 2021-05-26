//
//  MoviesViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 24.05.2021.
//

import UIKit


class MoviesViewController: UICollectionViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var movies = [MovieStruct]()
    private var networkManager = NetworkManager()
    var page = 1
    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @objc private func refresh() {
        guard !isLoading else { return }
        page = 1
        loadData()
    }
    
    func loadData() {
        isLoading = true
        activityIndicator.startAnimating()
        
        networkManager.performRequest(with: MoviesEndpoint.getMovies(page: page)) { [weak self] result in
            guard let self = self else { return }
                        
            switch result {
            case let .success(moviesData):
                if self.page == 1 {
                    self.movies += moviesData
                    self.page += 1
                }
                
            case let .failure(error):
                 DispatchQueue.main.async {
                     self.showError(error: error.localizedDescription)
                 }
             }
            
            DispatchQueue.main.async {
                 self.refreshControl.endRefreshing()
                 self.moviesCollectionView.reloadData()
                 self.isLoading = false
             }
        }
    }
    
    func showError(error: String) {
         let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
         let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in

         }

         alertController.addAction(errorAction)

         present(alertController, animated: true, completion: nil)
     }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)

        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
