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
    @IBOutlet weak var buttonThreeDMovies: UIBarButtonItem!

    // MARK: - Variables
    var moviesListViewModel = MoviesListViewModel()
    var searchController = UISearchController(searchResultsController: nil)

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMoviesListAPI()
        setUpUI()
    }

    // MARK: - Button Actions
    @IBAction func threeDMoviesButtonClicked(_ sender: UIBarButtonItem) {
        moviesListViewModel.dislpay3DMovies = !moviesListViewModel.dislpay3DMovies
        buttonThreeDMovies.title = moviesListViewModel.dislpay3DMovies ? "All" : "3D"
        fetchMoviesListAPI()
    }
    

    // MARK: - Initializing UI
    /// Customized UI
    func setUpUI() {
        //searchController.searchBar.isHidden = true
        self.title = "Movies List"
        tableViewMoviesList.dataSource = self
        tableViewMoviesList.delegate = self
        tableViewMoviesList.rowHeight = 120
        searchController.searchBar.delegate = self
        searchController.searchBar.becomeFirstResponder()
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableViewMoviesList.tableHeaderView = searchController.searchBar
    }

    // MARK: - API Methods
    /// getting MoviesListAPI
    func fetchMoviesListAPI() {
        showProgressHub()
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

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        moviesListViewModel.searchText = searchBar.text
        fetchMoviesListAPI()
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        moviesListViewModel.searchText = ""
        fetchMoviesListAPI()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
