//
//  CommandHandler.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-15.
//

import Foundation

protocol QueryHandler {
    associatedtype TQuery : Query
    mutating func execute(query: TQuery) async throws -> TQuery.TResult
}
