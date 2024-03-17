//
//  WeatherCondition.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

struct WeatherConditionDTO : Decodable {
    let text: String
    let code: WeatherIcon
}
