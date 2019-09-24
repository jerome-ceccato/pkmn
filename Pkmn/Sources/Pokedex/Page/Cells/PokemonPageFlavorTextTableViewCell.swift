//
//  PokemonPageFlavorTextTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 24/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageFlavorTextTableViewCell: UITableViewCell {
    @IBOutlet var flavorTextLabel: UILabel!

    func configure(with viewModel: PokemonPageViewModel.FlavorTextViewModel) {
        flavorTextLabel.text = viewModel.flavorText
    }
}
