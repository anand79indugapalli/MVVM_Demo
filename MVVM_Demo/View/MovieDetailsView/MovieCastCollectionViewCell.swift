//
//  MovieCastCollectionViewCell.swift
//  MVVM_Demo
//
//  Created by sai anand on 20/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageViewCharacterImage: UIImageView!
    @IBOutlet weak var labelNameNCharacter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView(imageView: imageViewCharacterImage, color: .black, borderWidth: 3, rounding: false)
    }
}
