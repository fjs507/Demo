//
//  Math.swift
//  Demo
//
//  Created by Farren Springer on 11/12/22.
//

import Foundation

enum MathError: Error {
    case unequalDimensions
    case emptyMatrix
}

struct Math {
    // MARK: Dot
    static func dot(_ matrixA: [Float],
                    _ matrixB: [Float]) throws -> Float {
        if matrixA.count != matrixB.count {
            throw MathError.unequalDimensions
        }
        
        var sum: Float = 0.0
        
        for i in 0..<matrixA.count {
            sum += matrixA[i] * matrixB[i]
        }
        
        return sum
    }
    
    // MARK: Transpose
    static func transpose(_ matrix: [[Float]]) throws -> [[Float]] {
        if matrix.count < 1 {
            throw MathError.emptyMatrix
        }
        var result: [[Float]] = Array(
            repeating: Array(
                repeating: 0,
                count: matrix.count),
            count: matrix[0].count)
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                result[j][i] = matrix[i][j]
            }
        }
        return result
    }
    
    // MARK: Multiply
    static func multiply(_ matrix: [[Float]],
                         byScalar scalar: Float) -> [[Float]] {
        var result: [[Float]] = []
        for i in 0..<matrix.count {
            var newRow: [Float] = []
            for j in 0..<matrix[i].count {
                newRow.append(matrix[i][j] * scalar)
            }
            result.append(newRow)
        }
        return result
    }
    
}
