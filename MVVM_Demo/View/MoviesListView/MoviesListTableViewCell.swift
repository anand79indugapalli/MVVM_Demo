//
//  MoviesListTableViewCell.swift
//  MVVM_Demo
//
//  Created by sai anand on 19/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieRating: UILabel!
    @IBOutlet weak var labelMovieRuntime: UILabel!
    @IBOutlet weak var labelMovieGenres: UILabel!
    @IBOutlet weak var imageViewMovieImage: UIImageView!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        customImageView(imageView: imageViewMovieImage, color: .black, borderWidth: 2, rounding: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
