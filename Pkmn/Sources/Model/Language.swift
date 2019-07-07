//
//  Language.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 07/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

struct Language {
    let identifier: Int
    let name: String
}

struct LocalizedItem {
    let identifier: Int
    let localizedName: String
}

typealias LocalizedItemMap = [Int: String]
