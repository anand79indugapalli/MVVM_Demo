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
    var moviesList: [MoviesList] = []
    var dislpay3DMovies: Bool = false
    var searchText: String?

    var searchUrl: String {
        var base_Url = "https://yts.am/api/v2/list_movies.json?"
        
        if dislpay3DMovies {
            base_Url = base_Url + "quality=3D"
        }
        if searchText != nil {
            if base_Url.contains("quality=3D") {
                base_Url = base_Url + "&query_term=\(String(describing: searchText!))"
            } else {
                base_Url = base_Url + "query_term=\(String(describing: searchText!))"
            }
        }

        return base_Url
    }
    
    func getMoviesList(_ completionHandler: @escaping(String?, Bool) -> Void) {
        print(searchUrl)
        NetworkManager.shared.requestFor(url: searchUrl, param: nil, httpMethod: .get, headerParam: nil, success: { (response) in
            let data = response["data"] as? [String: Any]
            if let arrData = data?["movies"] as? [NSDictionary] {
                self.moviesList = arrData.map { MoviesList($0)}
            } else {
                self.moviesList.removeAll()
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
