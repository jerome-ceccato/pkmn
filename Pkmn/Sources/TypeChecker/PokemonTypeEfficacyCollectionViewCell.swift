//
//  PokemonTypeEfficacyCollectionViewCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 29/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeEfficacyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
    
    func configure(with type: PokemonType) {
        containerView.backgroundColor = type.color()
        titleLabel.text = type.localizedName
    }
}
