//
//  PokedexTableViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 17/08/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var typesView: TypePokeballView!

    func configure(with viewModel: PokedexCellViewModel) {
        setupData(viewModel: viewModel.entryViewModel, filter: viewModel.filter)
    }
    
    private func setupData(viewModel: PokedexEntryViewModel, filter: String?) {
        let name = viewModel.name

        if let filter = filter,
            let range = name.range(of: filter, options: [.caseInsensitive, .diacriticInsensitive]) {
            let filteredText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 19),
                                                                                    .foregroundColor: UIColor.dynamicSecondaryLabel])
            
            filteredText.addAttribute(.foregroundColor,
                                      value: UIColor.dynamicLabel,
                                      range: NSRange(range, in: name))
            nameLabel.attributedText = filteredText
        } else {
            nameLabel.attributedText = viewModel.stylizedName(regularFont: UIFont.systemFont(ofSize: 19),
                                                              extraFont: UIFont.systemFont(ofSize: 15))
        }
        numberLabel.text = viewModel.pokedexNumber
        typesView.types = viewModel.types
        pictureImageView.image = viewModel.iconImage
    }
}
