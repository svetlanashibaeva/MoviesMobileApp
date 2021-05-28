//
//  MovieDetailsViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 27.05.2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    private var movieDetail: MovieDetail?
    private let movieDetailService = MovieDetailsService()
    var movieId: Int?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        loadData()
    }
    
    private func loadData() {
        guard let movieId = movieId else { return }
        movieDetailService.movieDetail(id: movieId) { [weak self] result in
            guard let self = self else { return }
             
            DispatchQueue.main.async {
                switch result {
                case let .success(movie):
                    self.movieDetail = movie
                    self.tableView.reloadData()
                case let .failure(error):
                    self.showError(error: error.localizedDescription) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                 }
             }
        }
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetail == nil ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieDetail = movieDetail else {
            return UITableViewCell()
        }
        
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.identifier, for: indexPath) as! MovieInfoCell
            cell.configure(with: movieDetail)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieOverviewCell.identifier, for: indexPath) as! MovieOverviewCell
            cell.configure(with: movieDetail.overview)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
    
}
