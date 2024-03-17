//
//  Weather.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

struct WeatherDTO: Decodable {
    let location: LocationDTO
    let current: WeatherDetailsDTO
}
