//
//  FiltersViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 07.06.2021.
//

import UIKit

class FiltersViewController: UITableViewController {

    @IBOutlet var filtersTableView: UITableView!
    
    private var genresArray = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show genres segue",
           let genreVC = segue.destination as? SelectGenreViewController {
            genreVC.selectedGenres = genresArray
            genreVC.delegate = self
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SortByCell.identifier, for: indexPath) as! SortByCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectGenresCell.identifier, for: indexPath) as! SelectGenresCell
            let text = genresArray.map({ $0.name.capitalized })
                                  .joined(separator: ", ")
            
            cell.configure(text: text)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.identifier, for: indexPath) as! RatingCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ShowButtonCell.identifier, for: indexPath) as! ShowButtonCell
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
        genresArray += genres
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    }
}
