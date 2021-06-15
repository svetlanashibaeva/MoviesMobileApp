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
    private var movieVideo: [Video]?
    private let movieDetailService = MovieDetailsService()
    private let movieVideoService = MovieVideoService()
    
    private var error: Error?
    
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
        
        let queue = DispatchQueue(label: "queue", attributes: .concurrent)
        let taskRequestGroup = DispatchGroup()
        
        guard let movieId = movieInfo?.id else { return }
        
        taskRequestGroup.enter()
        queue.async(group: taskRequestGroup) {
            self.movieDetailService.movieDetail(id: movieId) { [weak self] result in
                guard let self = self else { return }
   
                switch result {
                case let .success(movie):
                    self.movieDetail = movie
                case let .failure(error):
                    self.error = error
                }
                taskRequestGroup.leave()
            }
        }
        
        taskRequestGroup.enter()
        queue.async(group: taskRequestGroup) {
            self.movieVideoService.movieVideo(id: movieId) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success(responseVideo):
                    self.movieVideo = responseVideo.results
                case let .failure(error):
                    self.error = error
                }
                taskRequestGroup.leave()
            }
        }
        
        taskRequestGroup.notify(queue: .main) { [weak self] in
            if let error = self?.error {
                self?.showError(error: error.localizedDescription) { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
            } else {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
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
        return movieDetail == nil ? 0 : 3
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
        case 2:
            guard let movieVideo = movieVideo else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieVideoCell.identifier, for: indexPath) as! MovieVideoCell
            cell.configure(with: movieVideo)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 2 ? CGFloat(250) : UITableView.automaticDimension
    }
}
