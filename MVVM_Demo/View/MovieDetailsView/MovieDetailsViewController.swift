//
//  MovieDetailsViewController.swift
//  MVVM_Demo
//
//  Created by sai anand on 20/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var viewMovieDetails: MovieDetailsView!
    @IBOutlet weak var viewCastDetails: UIView!
    @IBOutlet weak var collectionViewMovieCast: UICollectionView!

    // MARK: - Variables
    var movieDetailsViewModel = MovieDetailsViewModel()
    var movieId: Int?

    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        showProgressHub()
        getMovieDetails()
        setUpUI()
    }

    // MARK: - Initializing UI
    /// Customized UI
    func setUpUI() {
        self.title = "Movie Details"
        collectionViewMovieCast.dataSource = self
        collectionViewMovieCast.delegate = self
    }

    /// displayMovieDetails
    func displayMovieDetails() {
        movieDetailsViewModel.displayMovieDetails(view: viewMovieDetails)
        if movieDetailsViewModel.castCount == 0 {
            viewCastDetails.isHidden = true
        }
    }

    // MARK: - API Methods
    /// getting Movie Details API
    func getMovieDetails() {
        movieDetailsViewModel.fetchMovieDetails(movieId: movieId!, { (responseMessage, success) in
            if success {
                print("Response call successful")
            } else {
                print(responseMessage ?? AlertActionText.someThingWentWrong)
            }
            self.displayMovieDetails()
            self.collectionViewMovieCast.reloadData()
            self.hideProgressHub()
        })
    }

}

extension MovieDetailsViewController: UICollectionViewDataSource {
    // MARK: - MovieCast DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailsViewModel.castCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionViewCell", for: indexPath) as? MovieCastCollectionViewCell else { return UICollectionViewCell() }
        movieDetailsViewModel.displayMovieCast(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - MovieCast DelegateFLowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

