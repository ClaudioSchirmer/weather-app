//
//  Icon.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

enum WeatherIcon : Int, Decodable {
    case Sunny = 1000
    case PartlyCoudy = 1003
    case Cloudy = 1006
    case Overcast = 1009
    case Mist = 1030
    case PatchyRainPossible = 1063
    case PatchySnowPossible = 1066
    case PatchySleetPossible = 1069
    case PatchyFreezingDrizzlePossible = 1072
    case ThunderyOutbreaksPossible = 1087
    case BlowingSnow = 1114
    case Blizzard = 1117
    case Fog = 1135
    case FreezingFog = 1147
    case PatchyLightDrizzle = 1150
    case LightDrizzle = 1153
    case FreezingDrizzle = 1168
    case HeavyFreezingDrizzle = 1171
    case PatchLightRain = 1180
    case LightRain = 1183
    case ModerateRainAtTimes = 1186
    case ModerateRain = 1189
    case HeavyRainAtTimes = 1192
    case HeavyRain = 1195
    case LightFreezingRain = 1198
    case ModerateOrHeavyFreezingRain = 1201
    case LightSleet = 1204
    case ModerateOrHeavySleet = 1207
    case PatchyLightSnow = 1210
    case LightSnow = 1213
    case PatchyModerateSnow = 1216
    case ModerateSnow = 1219
    case PatchyHeavySnow = 1222
    case HeavySnow = 1225
    case IcePellets = 1237
    case LightRainShower = 1240
    case ModerateOrHeavyRainShower = 1243
    case TorrentialRainShower = 1246
    case LightSleetShowers = 1249
    case ModerateOrHeavySleetShowers = 1252
    case LightSnowShowers = 1255
    case ModerateOrHeavySnowShowers = 1258
    case LightShowersOfIcePellets = 1261
    case ModerateOrHeavyShowersOfIcePellets = 1264
    case PatchyLightRainWithThunder = 1273
    case ModerateOrHeavyRainWithThunder = 1276
    case PatchyLightSnowWithThunder = 1279
    case ModerateOrHeavySnowWithThunder = 1282
    
    func getSymbol(isDay: Bool) -> String {
        WeatherIcon.getSymbolBy(isDay: isDay, code: self.rawValue)
    }
  
    static func getSymbolBy(isDay: Bool, code: Int) -> String {
        switch code {
        case WeatherIcon.Sunny.rawValue: isDay ? "sun.max" : "moon"
        case WeatherIcon.PartlyCoudy.rawValue: isDay ? "cloud.sun" : "cloud.moon"
        case WeatherIcon.Cloudy.rawValue : "cloud"
        case WeatherIcon.Overcast.rawValue : "cloud"
        case WeatherIcon.Mist.rawValue : "cloud"
        case WeatherIcon.PatchyRainPossible.rawValue : isDay ? "cloud.sun.rain" : "cloud.moon.rain"
        case WeatherIcon.PatchySnowPossible.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.PatchySleetPossible.rawValue: "cloud.sleet"
        case WeatherIcon.PatchyFreezingDrizzlePossible.rawValue : "cloud.drizzle"
        case WeatherIcon.ThunderyOutbreaksPossible.rawValue : isDay ? "cloud.sun.bolt" : "cloud.bolt"
        case WeatherIcon.BlowingSnow.rawValue : "wind.snow"
        case WeatherIcon.Blizzard.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.Fog.rawValue : "cloud.fog"
        case WeatherIcon.FreezingFog.rawValue : "cloud.fog"
        case WeatherIcon.PatchyLightDrizzle.rawValue : "cloud.drizzle"
        case WeatherIcon.LightDrizzle.rawValue : "cloud.drizzle"
        case WeatherIcon.FreezingDrizzle.rawValue : "cloud.drizzle"
        case WeatherIcon.HeavyFreezingDrizzle.rawValue : "cloud.drizzle"
        case WeatherIcon.PatchLightRain.rawValue : isDay ? "sun.rain" : "cloud.rain"
        case WeatherIcon.LightRain.rawValue : isDay ? "sun.rain" : "cloud.rain"
        case WeatherIcon.ModerateRainAtTimes.rawValue: isDay ? "sun.rain" : "cloud.rain"
        case WeatherIcon.ModerateRain.rawValue: isDay ? "sun.rain" : "cloud.rain"
        case WeatherIcon.HeavyRainAtTimes.rawValue: "cloud.heavyrain"
        case WeatherIcon.HeavyRain.rawValue: "cloud.heavyrain"
        case WeatherIcon.LightFreezingRain.rawValue: "cloud.drizzle"
        case WeatherIcon.ModerateOrHeavyFreezingRain.rawValue: "cloud.heavyrain"
        case WeatherIcon.LightSleet.rawValue:  "cloud.sleet"
        case WeatherIcon.ModerateOrHeavySleet.rawValue: "cloud.sleet"
        case WeatherIcon.PatchyLightSnow.rawValue: isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.LightSnow.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.PatchyModerateSnow.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.ModerateSnow.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.PatchyHeavySnow.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.HeavySnow.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.IcePellets.rawValue: "cloud.sleet"
        case WeatherIcon.LightRainShower.rawValue  : isDay ? "cloud.sun.rain" : "cloud.moon.rain"
        case WeatherIcon.ModerateOrHeavyRainShower.rawValue : isDay ? "cloud.sun.rain" : "cloud.moon.rain"
        case WeatherIcon.TorrentialRainShower.rawValue : isDay ? "cloud.sun.rain" : "cloud.moon.rain"
        case WeatherIcon.LightSleetShowers.rawValue :  "cloud.sleet"
        case WeatherIcon.ModerateOrHeavySleetShowers.rawValue :  "cloud.sleet"
        case WeatherIcon.LightSnowShowers.rawValue :  "cloud.sleet"
        case WeatherIcon.ModerateOrHeavySnowShowers.rawValue : isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.LightShowersOfIcePellets.rawValue:  "cloud.sleet"
        case WeatherIcon.ModerateOrHeavyShowersOfIcePellets.rawValue:  "cloud.sleet"
        case WeatherIcon.PatchyLightRainWithThunder.rawValue : isDay ? "cloud.sun.bolt" : "cloud.bolt"
        case WeatherIcon.ModerateOrHeavyRainWithThunder.rawValue : isDay ? "cloud.sun.bolt" : "cloud.bolt"
        case WeatherIcon.PatchyLightSnowWithThunder.rawValue: isDay ? "sun.snow" : "cloud.snow"
        case WeatherIcon.ModerateOrHeavySnowWithThunder.rawValue : isDay ? "sun.snow" : "cloud.snow"
        default:
            "questionmark.square.dashed"
        }
    }
}
