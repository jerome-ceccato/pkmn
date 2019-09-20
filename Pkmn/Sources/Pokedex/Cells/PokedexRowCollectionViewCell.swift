//
//  PokedexBaseCollectionViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexRowCollectionViewCell: UICollectionViewCell, PokedexCollectionCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var typesView: TypePokeballView!

    func configure(with viewModel: PokedexEntryViewModel) {
        nameLabel.text = viewModel.name
        numberLabel.text = viewModel.pokedexNumber
        typesView.types = viewModel.types
        pictureImageView.image = viewModel.iconImage
    }
}
