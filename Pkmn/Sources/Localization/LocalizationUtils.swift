//
//  LocalizationUtils.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 07/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

var localizationGlobalProvider: PokemonLocalization?

func pkmnLocalized(typeName: PokemonType) -> String {
    return localizationGlobalProvider?.typeNames[typeName.identifier] ?? typeName.name
}
