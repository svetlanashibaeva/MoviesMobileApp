//
//  SearchViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 29.05.2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchService = SearchService()
    
    private var movies = [MovieStruct]()
    private var selectedMovieId: Int?
    private var page = 1
    private var isLoading = false
    private var isListEnded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(FooterCollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                      withReuseIdentifier: FooterCollectionReusableView.identifier)
        loadData()
    }
    
    func loadData() {
        isLoading = true
        
        searchService.getList(query: "spider", page: page) { [weak self] result in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetails",
           let movieVC = segue.destination as? MovieDetailsViewController {
            movieVC.movieId = selectedMovieId
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
        selectedMovieId = movies[indexPath.item].id
        
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
            loadData()
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
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
