//
//  PokedexBaseCollectionViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexBaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var formLabel: UILabel!

    func configure(with viewModel: PokedexEntryViewModel) {
        nameLabel.text = viewModel.name
        formLabel.text = viewModel.subtitle
        pictureImageView.image = viewModel.iconImage
    }
}
