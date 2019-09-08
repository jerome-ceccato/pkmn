//
//  PokedexBaseTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexBaseTableViewCell: UITableViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    func configure(with pokedexEntry: PokedexEntry) {
        if pokedexEntry.species.identifier == pokedexEntry.pokemon.identifier {
            nameLabel.text = pokedexEntry.species.localizedName
        } else {
            nameLabel.text = "???"
        }
        pictureImageView.image = UIImage(named: "\(pokedexEntry.pokemon.identifier)")
    }
}
