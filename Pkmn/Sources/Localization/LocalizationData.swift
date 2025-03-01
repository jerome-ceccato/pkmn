//
//  LocalizationData.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 07/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit
import SQLite

class LocalizationData: DatabaseWrapper {
    let tableLanguages = Table("languages")
    let tableTypeNames = Table("type_names")
    let tableSpeciesNames = Table("pokemon_species_names")
    let tableFormNames = Table("pokemon_form_names")
    let tableSpeciesFlavorText = Table("pokemon_species_flavor_text")

    let columnId = Expression<Int>("id")
    let columnIdentifier = Expression<String>("identifier")
    let columnPokemonSpeciesId = Expression<Int>("pokemon_species_id")
    let columnLocaleId = Expression<Int>("local_language_id")
    let columnTypeId = Expression<Int>("type_id")
    let columnName = Expression<String>("name")
    let columnFormId = Expression<Int>("pokemon_form_id")
    let columnFormName = Expression<String?>("form_name")
    let columnSpeciesId = Expression<Int>("species_id")
    let columnLanguageId = Expression<Int>("language_id")
    let columnFlavorText = Expression<String>("flavor_text")
}

// Languages
extension LocalizationData {
    var languages: [Language] {
        return select(tableLanguages) { language in
            Language(identifier: language[columnId], name: language[columnIdentifier])
        }
    }
}

// Types
extension LocalizationData {
    func typeNames(for language: Language) -> [LocalizedItem] {
        return select(tableTypeNames.filter(columnLocaleId == language.identifier)) { item in
            LocalizedItem(identifier: item[columnTypeId], localizedName: item[columnName])
        }
    }
}

// Species
extension LocalizationData {
    func speciesNames(for language: Language) -> [LocalizedItem] {
        return select(tableSpeciesNames.filter(columnLocaleId == language.identifier)) { item in
            LocalizedItem(identifier: item[columnPokemonSpeciesId], localizedName: item[columnName])
        }
    }
    
    func speciesFlavorText(for language: Language) -> [LocalizedItem] {
        return select(tableSpeciesFlavorText.filter(columnLanguageId == language.identifier)) { item in
            LocalizedItem(identifier: item[columnSpeciesId], localizedName: item[columnFlavorText])
        }
    }
}

// Forms
extension LocalizationData {
    func formNames(for language: Language) -> [LocalizedItem] {
        return select(tableFormNames.filter(columnLocaleId == language.identifier)) { item in
            LocalizedItem(identifier: item[columnFormId], localizedName: item[columnFormName] ?? "")
        }
    }
}
