//
//  DemoTests.swift
//  DemoTests
//
//  Created by Farren Springer on 11/11/22.
//

import XCTest
@testable import Demo

final class DemoTests: XCTestCase {
    func test_Keychain_save_and_load() throws {
        let pokemon: Pokemon = Pokemon(
            baseExperience: 2,
            height: 4,
            id: 5,
            name: "test",
            order: 2,
            sprites: Sprites(frontDefault: "testFrontDefault"),
            weight: 10)
        do {
            let data = try JSONEncoder().encode(pokemon)
            let status = Keychain.save(key: "TestData", data: data)
            print("status: ", status)
            if let receivedData = Keychain.load(key: "TestData") {
                do {
                    let result = try JSONDecoder().decode(Pokemon.self, from: receivedData)
                    print("result: ", result)
                    XCTAssertEqual(result, pokemon)
                } catch let error {
                    XCTFail("Error, \(error)")
                }
            }
        } catch let error {
            XCTFail("Error, \(error)")
        }
    }
}

