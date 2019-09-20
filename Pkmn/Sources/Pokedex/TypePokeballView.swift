//
//  TypePokeballView.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 20/09/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class TypePokeballView: UIView {
    var types: PokemonTypes? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(),
            let types = types else {
            return
        }
        
        let width: CGFloat = 6
        context.setLineWidth(width)
        
        drawArc(context: context, width: width, startAngle: 0, color: types.primaryType.color())
        drawArc(context: context, width: width, startAngle: .pi, color: (types.secondaryType ?? types.primaryType).color())
    }
    
    private func drawArc(context: CGContext, width: CGFloat, startAngle: CGFloat, color: UIColor) {
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = (frame.size.width - (width * 2)) / 2

        color.set()
        context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: startAngle + .pi, clockwise: true)
        context.strokePath()
    }
}
