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
    
    private var movieListService = MovieListService()
    
    private var movies = [MovieStruct]()
    private var selectedMovie: MovieStruct?
    private var page = 1
    private var isLoading = false
    private var isListEnded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        moviesCollectionView.refreshControl = refreshControl
        moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        moviesCollectionView.register(FooterCollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                      withReuseIdentifier: FooterCollectionReusableView.identifier)
        loadData()
    }
    
    @objc private func refresh() {
        guard !isLoading else { return }
        page = 1
        loadData()
    }
    
    func loadData() {
        isLoading = true
        
        movieListService.getList(page: page) { [weak self] result in
            guard let self = self else { return }
                        
            switch result {
            case let .success(response):
                let movies = response.results
                
                 if self.page == 1 {
                     self.movies = movies
                 } else {
                     self.movies += movies
                 }
                self.isListEnded = movies.isEmpty
                self.page += 1
                
            case let .failure(error):
                 DispatchQueue.main.async {
                     self.showError(error: error.localizedDescription)
                 }
             }
            
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    self.refreshControl.endRefreshing()
                }
                 self.moviesCollectionView.reloadData()
                 self.isLoading = false
             }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails",
           let movieVC = segue.destination as? MovieDetailsViewController,
           let id = selectedMovie?.id,
           let title = selectedMovie?.title {
            movieVC.movieInfo = MovieInfo(id, title)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isLoading else { return }
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - scrollView.contentOffset.y <= 0 {
            loadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedMovie = movies[indexPath.item]
        
        performSegue(withIdentifier: "MovieDetails", sender: self)
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(
                     ofKind: UICollectionView.elementKindSectionFooter,
                     withReuseIdentifier: FooterCollectionReusableView.identifier,
                     for: indexPath
        ) as! FooterCollectionReusableView
        
        footer.configure()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard !isListEnded else {
            return .zero
        }
        
        return CGSize(width: view.frame.size.width, height: 36)
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
