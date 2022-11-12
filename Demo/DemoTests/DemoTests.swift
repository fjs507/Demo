//
//  DemoTests.swift
//  DemoTests
//
//  Created by Farren Springer on 11/11/22.
//

import XCTest
@testable import Demo

final class DemoTests: XCTestCase {
    // MARK: Keychain
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
    
    // MARK: Math
    func test_dot() throws {
        let matrixA: [Float] = [3.0, 5.0, 7.0]
        let matrixB: [Float] = [2.0, 7.0, 1.3]
        
        let expectedResult: Float = 6.0 + 35.0 + (7.0 * 1.3)
        let actualResult = try Math.dot(matrixA, matrixB)
        
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func test_transpose() throws {
        let matrix: [[Float]] = [
            [1.0, 2.0, 3.0, 10.0],
            [4.0, 5.0, 6.0, 11.0],
            [7.0, 8.0, 9.0, 12.0]
        ]
        
        let expectedResult: [[Float]] = [
            [1.0, 4.0, 7.0],
            [2.0, 5.0, 8.0],
            [3.0, 6.0, 9.0],
            [10.0, 11.0, 12.0]
        ]
        let actualResult = try Math.transpose(matrix)
        
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func test_multiplyByScalar() throws {
        let matrix: [[Float]] = [
            [1.0, 2.0, 3.0, 10.0],
            [4.0, 5.0, 6.0, 11.0],
            [7.0, 8.0, 9.0, 12.0]
        ]
        let scalar: Float = 2.0
        
        let expectedResult: [[Float]] = [
            [2.0, 4.0, 6.0, 20.0],
            [8.0, 10.0, 12.0, 22.0],
            [14.0, 16.0, 18.0, 24.0]
        ]
        let actualResult = Math.multiply(matrix, byScalar: scalar)
        
        XCTAssertEqual(actualResult, expectedResult)
    }
}

