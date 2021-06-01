//
//  MovieDetailsViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 27.05.2021.
//

import UIKit

typealias MovieInfo = (id: Int, title: String)

class MovieDetailsViewController: UIViewController {
    
    private var movieDetail: MovieDetail?
    private let movieDetailService = MovieDetailsService()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    var movieInfo: MovieInfo?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        title = movieInfo?.title
        
        loadData()
    }
    
    private func loadData() {
        showActivityIndicator()
        
        guard let movieId = movieInfo?.id else { return }
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
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showActivityIndicator() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
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
