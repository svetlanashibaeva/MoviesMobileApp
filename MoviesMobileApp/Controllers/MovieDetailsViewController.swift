//
//  MovieDetailsViewController.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 27.05.2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello"
        return cell
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
    
}
