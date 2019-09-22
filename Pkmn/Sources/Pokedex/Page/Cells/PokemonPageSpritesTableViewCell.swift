//
//  PokemonPageSpritesTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 22/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageSpritesTableViewCell: UITableViewCell {
    @IBOutlet var regularImageView: UIImageView!
    @IBOutlet var shinyImageView: UIImageView!

    func configure(with viewModel: PokemonPageViewModel.SpritesViewModel) {
        regularImageView.image = viewModel.images[0]
        shinyImageView.image = viewModel.images[1]
    }
}
