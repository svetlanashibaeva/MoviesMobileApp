//
//  SearchViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 29.05.2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchController = UISearchController()
    
    private var searchService = SearchService()
    
    private var movies = [MovieStruct]()
    private var selectedMovie: MovieStruct?
    private var page = 1
    private var isLoading = false
    private var isListEnded = true
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Искать..."
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(FooterCollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                      withReuseIdentifier: FooterCollectionReusableView.identifier)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func loadData(query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }
        
        isLoading = true
        
        searchService.getList(query: query, page: page) { [weak self] result in
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
                 self.collectionView.reloadData()
                 self.isLoading = false
             }
        }
    }
    
    private func clear() {
        isListEnded = true
        movies = []
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails",
           let movieVC = segue.destination as? MovieDetailsViewController,
           let id = selectedMovie?.id,
           let title = selectedMovie?.title {
            movieVC.movieInfo = MovieInfo(id, title)
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedMovie = movies[indexPath.item]
        
        performSegue(withIdentifier: "MovieDetails", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterCollectionReusableView.identifier,
            for: indexPath
        ) as! FooterCollectionReusableView
        
        footer.configure()
        
        return footer
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isLoading else { return }
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - scrollView.contentOffset.y <= 0 {
            loadData(query: searchController.searchBar.text)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: { [weak self] () -> UIViewController? in
            guard let self = self else { return nil }
            let movie = self.movies[indexPath.item]
            
            let detailsViewController = self.navigationController?.storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
            
            guard let id = movie.id, let title = movie.title else { return nil }
            
            detailsViewController?.movieInfo = MovieInfo(id, title)
            
            return detailsViewController
        })
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.6)
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

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            clear()
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] (timer) in
            self?.page = 1
            self?.isListEnded = false
            self?.loadData(query: searchText)
        })
    }
}
