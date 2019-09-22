//
//  PokemonPageNameTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 21/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonPageHeaderTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var singleTypeView: UIView!
    @IBOutlet var singleTypeViewType: PokemonDefaultTypeView!
    @IBOutlet var doubleTypeView: UIView!
    @IBOutlet var doubleTypeViewFirstType: PokemonDefaultTypeView!
    @IBOutlet var doubleTypeViewSecondType: PokemonDefaultTypeView!
    @IBOutlet var flavorTextLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    func configure(with viewModel: PokemonPageViewModel.HeaderViewModel) {
        nameLabel.text = viewModel.name
        setupType(viewModel.types)
        flavorTextLabel.text = viewModel.flavorText
        iconImageView.image = viewModel.backgroundImage?.withRenderingMode(.alwaysTemplate)
    }

    private func setupType(_ type: PokemonTypes) {
        if let secondType = type.secondaryType {
            singleTypeView.isHidden = true
            doubleTypeView.isHidden = false
            doubleTypeViewFirstType.configure(with: type.primaryType)
            doubleTypeViewSecondType.configure(with: secondType)
        } else {
            doubleTypeView.isHidden = true
            singleTypeView.isHidden = false
            singleTypeViewType.configure(with: type.primaryType)
        }
    }
}
