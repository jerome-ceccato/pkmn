//
//  PokemonLocalization.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 07/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonLocalization {
    private let db: LocalizationData
    
    init(db: LocalizationData) {
        self.db = db
    }
    
    lazy var languages = db.languages

    lazy var currentLanguage: Language = {
        for userLanguage in NSLocale.preferredLanguages {
            for language in languages {
                if userLanguage.starts(with: language.name) {
                    return language
                }
            }
        }
        return languages.first(where: { $0.name == "en" })!
    }()
    
    lazy var typeNames: LocalizedItemMap = {
       index(items: db.typeNames(for: currentLanguage))
    }()
    
    lazy var speciesNames: LocalizedItemMap = {
        index(items: db.speciesNames(for: currentLanguage))
    }()
    
    lazy var formNames: LocalizedItemMap = {
        index(items: db.formNames(for: currentLanguage))
    }()
    
    lazy var speciesFlavorText: LocalizedItemMap = {
        index(items: db.speciesFlavorText(for: currentLanguage))
    }()
}

private extension PokemonLocalization {
    func index(items: [LocalizedItem]) -> LocalizedItemMap {
        return items.reduce(into: [:], { res, item in
            res[item.identifier] = item.localizedName
        })
    }
}
