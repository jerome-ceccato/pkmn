//
//  Collection+SafeSubscript.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 28/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
