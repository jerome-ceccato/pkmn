//
//  PokemonPageEvolutionEntryTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 12/12/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageEvolutionEntryTableViewCell: UITableViewCell {
    @IBOutlet var speciesNameLabel: UILabel!
    @IBOutlet var evolutionTriggerLabel: UILabel!

    func configure(with viewModel: PokemonPageViewModel.EvolutionLineViewModel) {
        speciesNameLabel.text = viewModel.speciesName
        evolutionTriggerLabel.text = viewModel.evolutionTrigger
    }
}
