//
//  DatabaseWrapper.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 07/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit
import SQLite

class DatabaseWrapper {
    private let db: Connection
    
    init(handler: Connection) {
        self.db = handler
    }
}

// Helpers
extension DatabaseWrapper {
    func select<T>(_ query: QueryType, transform: (Row) -> T) -> [T] {
        return (try? db.prepare(query).map(transform)) ?? []
    }
    
    func count(_ query: SchemaType) -> Int {
        return (try? db.scalar(query.count)) ?? 0
    }
}
