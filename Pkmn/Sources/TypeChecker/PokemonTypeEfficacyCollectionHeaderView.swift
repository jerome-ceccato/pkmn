//
//  PokemonTypeEfficacyCollectionReusableView.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 29/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeEfficacyCollectionHeaderView: UICollectionReusableView {
    var titleLabel: UILabel!

    func configure(with viewModel: PokemonTypeCheckerEfficacyCategoryViewModel) {
        setupSubviewsIfNeeded()
        
        titleLabel.text = viewModel.multiplierDisplayString
        titleLabel.textColor = viewModel.tintColor
        titleLabel.font = viewModel.multiplierFont
    }
}

private extension PokemonTypeEfficacyCollectionHeaderView {
    func setupSubviewsIfNeeded() {
        guard titleLabel == nil else {
            return
        }

        titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel, pinnedToEdges: .zero)
    }
}
