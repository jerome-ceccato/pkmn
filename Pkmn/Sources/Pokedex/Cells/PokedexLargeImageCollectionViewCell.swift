//
//  PokedexLargeImageCollectionViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 18/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexLargeImageCollectionViewCell: UICollectionViewCell, PokedexCollectionCell {
    @IBOutlet var pictureImageView: UIImageView!
    
    func configure(with viewModel: PokedexEntryViewModel) {
        pictureImageView.image = viewModel.mainImage
    }
}
