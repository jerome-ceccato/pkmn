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
    
    let columnId = Expression<Int>("id")
    let columnIdentifier = Expression<String>("identifier")
    let columnLocaleId = Expression<Int>("local_language_id")
    let columnTypeId = Expression<Int>("type_id")
    let columnName = Expression<String>("name")
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
