//
//  MoviesListModel.swift
//  MVVM_Demo
//
//  Created by sai anand on 19/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import Foundation

struct MoviesList {
    var movieId: Int?
    var title: String?
    var rating: Double?
    var runTime: Int?
    var imageUrl: String?
    var genres: [String] = []

    init(_ data: NSDictionary) {
        movieId = data.value(forKey: "id") as? Int  ?? 0
        title = data.value(forKey: "title_long") as? String ?? ""
        rating = data.value(forKey: "rating") as? Double ?? 0.0
        runTime = data.value(forKey: "runtime") as? Int ?? 0
        imageUrl = data.value(forKey: "medium_cover_image") as? String ?? ""
        genres = data.value(forKey: "genres") as? [String] ?? []
    }
}
