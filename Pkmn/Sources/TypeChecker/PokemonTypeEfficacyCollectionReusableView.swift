//
//  PokemonTypeEfficacyCollectionReusableView.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 29/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeEfficacyCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var visualIndicatorView: UIView!
    @IBOutlet weak var multiplierLabel: UILabel!
    
    @IBOutlet var visualIndicatorWidthConstraint: NSLayoutConstraint!
    @IBOutlet var visualIndicatorHiddenConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        visualIndicatorView.layer.cornerRadius = 4
        visualIndicatorView.layer.masksToBounds = true
    }
    
    func configure(with viewModel: PokemonTypeCheckerEfficacyCategoryViewModel) {
        titleLabel.text = viewModel.displayString
        multiplierLabel.text = viewModel.multiplierDisplayString
        visualIndicatorView.backgroundColor = viewModel.tintColor

        updateIndicatorConstraint(multiplier: viewModel.visualIndicatorWidthMultiplier)
        visualIndicatorHiddenConstraint.isActive = viewModel.visualIndicatorWidthMultiplier == 0
    }
    
    private func updateIndicatorConstraint(multiplier: CGFloat) {
        NSLayoutConstraint.deactivate([visualIndicatorWidthConstraint])
        
        let newConstraint = visualIndicatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
        visualIndicatorWidthConstraint = newConstraint

        NSLayoutConstraint.activate([newConstraint])
    }
}

private extension PokemonTypeEfficacyCollectionReusableView {
 
}
