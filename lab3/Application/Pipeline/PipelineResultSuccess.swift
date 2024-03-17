//
//  PipelineResultSuccess.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-17.
//

import Foundation

struct PipelineResultSuccess<TQuery: Query> : PipelineResult {   
    let result: TQuery.TResult
}
