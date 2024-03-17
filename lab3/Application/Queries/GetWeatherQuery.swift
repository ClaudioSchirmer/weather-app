//
//  GetWeatherQuery.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-15.
//

import Foundation

struct GetWeatherQuery : Query {
    typealias TResult = WeatherDTO
    
    let location: String?
}
