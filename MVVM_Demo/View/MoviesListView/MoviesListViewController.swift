//
//  MoviesListViewController.swift
//  MVVM_Demo
//
//  Created by sai anand on 19/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableViewMoviesList: UITableView!

    // MARK: - Variables
    var moviesListViewModel = MoviesListViewModel()

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProgressHub()
        fetchMoviesListAPI()
        setUpUI()
    }

    // MARK: - Initializing UI
    /// Customized UI
    func setUpUI() {
        tableViewMoviesList.dataSource = self
        tableViewMoviesList.delegate = self
        tableViewMoviesList.rowHeight = 120
    }

    // MARK: - API Methods
    /// getting MoviesListAPI
    func fetchMoviesListAPI() {
        moviesListViewModel.getMoviesList { (message, success) in
            if success {
                print("response call successful")
            } else {
                print(message ?? AlertActionText.someThingWentWrong)
            }
            self.tableViewMoviesList.reloadData()
            self.hideProgressHub()
        }
    }
}


extension MoviesListViewController: UITableViewDataSource {
    // MARK: - MoviesList DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesListViewModel.moviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell") as? MoviesListTableViewCell else { return UITableViewCell() }
        moviesListViewModel.getMoviesList(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension MoviesListViewController: UITableViewDelegate {
    // MARK: - MoviesList Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        newViewController.movieId = moviesListViewModel.movieId(indexPath: indexPath.row)
        navigationController?.pushViewController(newViewController, animated: true)
    }
}
