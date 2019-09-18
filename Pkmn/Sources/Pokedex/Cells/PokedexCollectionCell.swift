//
//  PokedexCollectionCell.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 18/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import Foundation

protocol PokedexCollectionCell {
    func configure(with viewModel: PokedexEntryViewModel)
}
