//
//  MovieDetailsView.swift
//  MVVM_Demo
//
//  Created by sai anand on 21/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var imageViewMovieImage: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    @IBOutlet weak var labelMovieGenres: UILabel!
    @IBOutlet weak var labelMovieRating: UILabel!
    @IBOutlet weak var labelMovieLanguage: UILabel!
    @IBOutlet weak var labelMovieDownloads: UILabel!
    @IBOutlet weak var labelMovieUploaded: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView(imageView: imageViewMovieImage, color: .white, borderWidth: 5, rounding: false)
    }
}
