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
        
        if let secondaryType = types.secondaryType {
            drawArc(context: context, width: width, from: 0, to: .pi, color: types.primaryType.color())
            drawArc(context: context, width: width, from: .pi, to: .pi * 2, color: secondaryType.color())
        } else {
            drawArc(context: context, width: width, from: 0, to: .pi * 2, color: types.primaryType.color())
        }
    }
    
    private func drawArc(context: CGContext, width: CGFloat, from: CGFloat, to: CGFloat, color: UIColor) {
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = (frame.size.width - (width * 2)) / 2

        color.set()
        context.addArc(center: center, radius: radius, startAngle: from, endAngle: to, clockwise: true)
        context.strokePath()
    }
}
