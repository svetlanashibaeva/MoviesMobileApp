//
//  FiltersViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 07.06.2021.
//

import UIKit

class FiltersViewController: UITableViewController {
    
    var filters = [Filter]()
    
    private var genresArray: [Genre] {
        return filters.compactMap { filter -> [Genre]? in
            guard case let .genres(genres) = filter else { return nil }
            return genres
        }.first ?? []
    }
    
    weak var delegate: SelectedFiltersDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show genres segue",
           let genreVC = segue.destination as? SelectGenreViewController {
            genreVC.selectedGenres = genresArray
            genreVC.delegate = self
        }
    }
    
    @objc private func showButtonClick() {
        let filters = tableView.visibleCells.compactMap { cell -> Filter? in
            return (cell as? FiltersProtocol)?.getFilter()
        }
        delegate?.returnFilters(filters: filters)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetFilters(_ sender: Any) {
        filters = []
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SortByCell.identifier, for: indexPath) as! SortByCell
            let sort = filters.compactMap { filter -> SortBy? in
                guard case let .sortBy(sort) = filter else { return nil }
                return sort
            }
            .first
            
            cell.configure(sort: sort ?? .popularity)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectGenresCell.identifier, for: indexPath) as! SelectGenresCell
            
            cell.configure(genres: genresArray)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.identifier, for: indexPath) as! RatingCell
            let value = filters.compactMap { filter -> String? in
                guard case let .rating(value) = filter else { return nil }
                return value
            }
            .first
            
            cell.configure(value: value ?? "5.0")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ShowButtonCell.identifier, for: indexPath) as! ShowButtonCell
            cell.showButton.addTarget(self, action: #selector(showButtonClick), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            performSegue(withIdentifier: "Show genres segue", sender: self)
        }
    }
}

extension FiltersViewController: SelectedGenresDelegate {
    func returnGenres(genres: [Genre]) {
        if let index = filters.firstIndex(where: { (filter) -> Bool in
            if case .genres = filter {
                return true
            }
            return false
        }) {
            filters.remove(at: index)
        }
        
        filters.append(.genres(by: genres))
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    }
}
