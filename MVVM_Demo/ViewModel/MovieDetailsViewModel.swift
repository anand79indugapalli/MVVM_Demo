//
//  MovieDetailsViewModel.swift
//  MVVM_Demo
//
//  Created by sai anand on 20/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    
    let base_Url = "https://yts.am/api/v2/movie_details.json?with_images=true&with_cast=true&movie_id="

    var movieDetails: MoviesDetailsModel?

    func fetchMovieDetails(movieId: Int, _ completionHandler: @escaping(String?, Bool) -> Void) {
        let url = base_Url + "\(movieId)"
        NetworkManager.shared.requestFor(url: url, param: nil, httpMethod: .get, headerParam: nil, success: { (response) in
            let data = response["data"] as? NSDictionary
            if let movData = data!["movie"] as? NSDictionary {
                self.movieDetails = MoviesDetailsModel(movData)
            }
            completionHandler("", true)
        }, failure: { (failureResponse) in
            let errorMessage = failureResponse["message"] as? String ?? ""
            completionHandler(errorMessage, false)
        })
    }

    var castCount: Int {
        return movieDetails?.cast.count ?? 0
    }

    func displayMovieDetails(view: MovieDetailsView) {
        view.imageViewMovieImage.kf.setImage(with: URL(string: (movieDetails?.movieUrl ?? "")!))
        view.labelMovieTitle.text = movieDetails?.name
        view.labelMovieGenres.text = (movieDetails?.genres.isEmpty ?? true) ? "None": movieDetails?.genres.joined(separator: "/")
        view.labelMovieYear.text = String(describing: movieDetails?.year ?? 0)
        view.labelMovieRating.text = "IMDB: " + String(describing: movieDetails?.rating ?? 0.0)
        view.labelMovieDownloads.text = "Downloads: " + String(describing: movieDetails?.downloads ?? 0)
        view.labelMovieUploaded.text = movieDetails?.uploaded
        view.labelMovieLanguage.text = movieDetails?.language
        view.labelMovieDescription.text = movieDetails?.description
    }

    func displayMovieCast(cell: MovieCastCollectionViewCell, indexPath: IndexPath) {
        cell.imageViewCharacterImage.kf.setImage(with: URL(string: movieDetails?.cast[indexPath.row].url_small_image ?? ""))
        let characterName = (movieDetails?.cast[indexPath.row].name ?? "") + " as " + (movieDetails?.cast[indexPath.row].character_name ?? "")
        cell.labelNameNCharacter.text = characterName
    }
}
