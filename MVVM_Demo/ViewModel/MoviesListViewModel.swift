//
//  MoviesListViewModel.swift
//  MVVM_Demo
//
//  Created by sai anand on 19/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import Foundation

class MoviesListViewModel {

    // MARK: - Variables
    let base_Url = "https://yts.am/api/v2/list_movies.json?"
    var moviesList: [MoviesList] = []
    
    func getMoviesList(_ completionHandler: @escaping(String?, Bool) -> Void) {
        NetworkManager.shared.requestFor(url: base_Url, param: nil, httpMethod: .get, headerParam: nil, success: { (response) in
            let data = response["data"] as? [String: Any]
            if let arrData = data?["movies"] as? [NSDictionary] {
                self.moviesList = arrData.map { MoviesList($0)}
            }
            completionHandler("", true)
        }, failure: { (failureResponse) in
            let errorMessage = failureResponse["message"] as? String ?? ""
            completionHandler(errorMessage, false)
        })
    }

    func getMoviesList(cell: MoviesListTableViewCell, indexPath: IndexPath) {
        cell.imageViewMovieImage.kf.setImage(with: URL(string: moviesList[indexPath.row].imageUrl!))
        cell.labelMovieTitle.text = moviesList[indexPath.row].title
        cell.labelMovieRuntime.text = String(describing: moviesList[indexPath.row].runTime!)
        cell.labelMovieRating.text = "IMDB: \(String(describing: moviesList[indexPath.row].rating!))"
        cell.labelMovieGenres.text = moviesList[indexPath.row].genres.isEmpty ? "None" : moviesList[indexPath.row].genres.joined(separator: "/")
    }

    var moviesCount: Int {
        return moviesList.count
    }

    func movieId(indexPath: Int) -> Int {
        guard moviesCount > indexPath else { return 0 }
        return moviesList[indexPath].movieId!
    }
}
