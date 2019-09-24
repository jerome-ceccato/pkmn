//
//  PokemonPageArtworkTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 24/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageArtworkTableViewCell: UITableViewCell {
    @IBOutlet var fullImageView: UIImageView!

    func configure(with viewModel: PokemonPageViewModel.ArtworkViewModel) {
        fullImageView.image = viewModel.artworkImage
    }
}
