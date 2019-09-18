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

    func configure(with pokedexEntry: PokedexEntry) {
        nameLabel.text = pokedexEntry.species.localizedName

        if pokedexEntry.species.identifier == pokedexEntry.pokemon.identifier {
            formLabel.text = ""
        } else if let form = pokedexEntry.forms.first {
            formLabel.text = form.localizedName
        } else {
            formLabel.text = "???"
        }

        if let image = UIImage(named: "\(pokedexEntry.pokemon.identifier)") {
            pictureImageView.image = image
        } else if let form = pokedexEntry.forms.first,
            let image = UIImage(named: "\(pokedexEntry.species.identifier)-\(form.formIdentifier)") {
            pictureImageView.image = image
        } else {
            print("No image for \(pokedexEntry.species.name) - \(pokedexEntry.pokemon.identifier) - \(pokedexEntry.pokemon.name)")
            pictureImageView.image = nil
        }

    }
}
