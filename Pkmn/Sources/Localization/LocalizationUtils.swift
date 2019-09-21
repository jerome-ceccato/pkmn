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

func pkmnLocalized(speciesName: PokemonSpecies) -> String {
    return localizationGlobalProvider?.speciesNames[speciesName.identifier] ?? speciesName.name
}

func pkmnLocalized(formName: PokemonForm) -> String {
    return localizationGlobalProvider?.formNames[formName.identifier] ?? formName.name
}

func pkmnLocalized(speciesFlavorText species: PokemonSpecies) -> String {
    return localizationGlobalProvider?.speciesFlavorText[species.identifier] ?? ""
}

// Global helpers

func pkmnLocalizedString(_ content: String) -> String {
    return NSLocalizedString(content, comment: content)
}
func pkmnLocalizedString(format: String, _ arguments: CVarArg...) -> String {
    return String(format: NSLocalizedString(format, comment: format),
                  locale: .current,
                  arguments: arguments)
}

func pkmnLocalizedNumber(_ number: NSNumber) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = NSLocale.current
    
    return formatter.string(from: number) ?? number.stringValue
}
