//
//  WeatherDetails.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

struct WeatherDetailsDTO : Decodable {
    let temp_c: Float
    let temp_f: Float
    let is_day: Int
    let condition: WeatherConditionDTO
}
