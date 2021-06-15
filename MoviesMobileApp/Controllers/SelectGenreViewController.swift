//
//  SelectGenreViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 08.06.2021.
//

import UIKit

class SelectGenreViewController: UITableViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var genres = [Genre]()
    private let genreService = GenreService()
    
    private var error: Error?
    
    var selectedGenres = [Genre]()
    weak var delegate: SelectedGenresDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        loadData()
    }
    
    @IBAction func buttonSelectClick(_ sender: Any) {
        delegate?.returnGenres(genres: selectedGenres)
        navigationController?.popViewController(animated: true)
    }
    
    private func loadData() {
        showActivityIndicator()
        
        genreService.genresList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                self.genres = response.genres
            case let .failure(error):
                 DispatchQueue.main.async {
                     self.showError(error: error.localizedDescription)
                 }
             }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreNameCell.identifier, for: indexPath) as! GenreNameCell
        let genre = genres[indexPath.row]
        let isSelected = selectedGenres.contains(genre)
        cell.configure(with: genre, isSelected: isSelected)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let genre = genres[indexPath.row]
        if let index = selectedGenres.firstIndex(of: genre) {
            selectedGenres.remove(at: index)
        } else {
            selectedGenres.append(genre)
        }

        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
