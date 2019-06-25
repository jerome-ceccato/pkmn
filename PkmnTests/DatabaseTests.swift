//
//  DatabaseTests.swift
//  PkmnTests
//
//  Created by Jerome Ceccato on 24/06/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import XCTest
@testable import Pkmn
@testable import SQLite

// These checks are here to easily detect some major and possibly app breaking changes when updating the database
// The app's UI may make assumptions based on these values for better UX
class DatabaseTests: XCTestCase {

    var database: Database!
    
    override func setUp() {
        self.database = try? Database(filename: "db")
    }
    
    func testNumberOfTypes() {
        XCTAssertEqual(self.database.types.count, 18)
    }
    
    func testComprehensiveTypeEfficacyMap() {
        XCTAssertEqual(self.database.typeEfficacy.count, 18 * 18)
    }
    
    func testNumberOfPokemon() {
        XCTAssertEqual(self.database.numberOfPokemon, 807)
    }
}
