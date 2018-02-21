//
//  MovieDetailsModel.swift
//  MVVM_Demo
//
//  Created by sai anand on 20/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import Foundation

struct MoviesDetailsModel {
    var movieId: Int?
    var movieUrl: String?
    var name: String?
    var year: Int?
    var genres: [String] = []
    var rating: Double?
    var language: String?
    var downloads: Int?
    var uploaded: String?
    var description: String?
    var cast: [MovieCastModel] = []

    init(_ data: NSDictionary) {
        movieId = data.value(forKey: "id") as? Int ?? 0
        movieUrl = data.value(forKey: "medium_cover_image") as? String ?? ""
        name = data.value(forKey: "title_english") as? String ?? ""
        year = data.value(forKey: "year") as? Int ?? 0
        genres = data.value(forKey: "genres") as? [String] ?? []
        rating = data.value(forKey: "rating") as? Double ?? 0.0
        language = data.value(forKey: "language") as? String ?? ""
        downloads = data.value(forKey: "download_count") as? Int ?? 0
        let date = data.value(forKey: "date_uploaded") as? String ?? ""
        uploaded = date.dateConverstion()
        description = data.value(forKey: "description_full") as? String ?? ""
        let arrdata = data.value(forKey: "cast") as? [NSDictionary]
        cast = arrdata?.map { MovieCastModel($0) } ?? []
    }
}

struct MovieCastModel {
    var name: String?
    var character_name: String?
    var url_small_image: String?

    init(_ data: NSDictionary) {
        name = data.value(forKey: "name") as? String ?? ""
        character_name = data.value(forKey: "character_name") as? String ?? ""
        url_small_image = data.value(forKey: "url_small_image") as? String ?? ""
    }
}
