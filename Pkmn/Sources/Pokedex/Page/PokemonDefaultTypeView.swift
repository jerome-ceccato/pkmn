//
//  PokemonDefaultTypeView.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 21/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonDefaultTypeView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    func configure(with type: PokemonType) {
        backgroundColor = type.color()
        titleLabel.text = type.localizedName
    }
}
