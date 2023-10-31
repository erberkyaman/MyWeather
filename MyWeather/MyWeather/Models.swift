//
//  Models.swift
//  MyWeather
//
//  Created by Erberk Yaman on 23.10.2023.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let queryCost: Int
    let latitude, longitude: Double
    let resolvedAddress, address, timezone: String
    let tzoffset: Int
    let description: String
    let days: [CurrentConditions]
    //let alerts: [Any]
    let stations: [String: Station]
    let currentConditions: CurrentConditions
}

// MARK: - CurrentConditions
struct CurrentConditions: Codable {
    let datetime: String?
    let datetimeEpoch: Int?
    let temp, feelslike, humidity, dew: Double?
    let precip: Double?
    let precipprob: Double?
    let snow: Int?
    let snowdepth: Int?
    let preciptype: [Icon]?
    let windgust, windspeed, winddir, pressure: Double?
    let visibility, cloudcover, solarradiation, solarenergy: Double?
    let uvindex: Int?
    let conditions: Conditions?
    let icon: Icon?
    let stations: [ID]?
    let source: Source?
    let sunrise: String?
    let sunriseEpoch: Int?
    let sunset: String?
    let sunsetEpoch: Int?
    let moonphase, tempmax, tempmin, feelslikemax: Double?
    let feelslikemin, precipcover: Double?
    let severerisk: Int?
    let description: String?
    let hours: [HourlyConditions]?
}

enum Conditions: String, Codable {
    case clear = "Clear"
    case overcast = "Overcast"
    case partiallyCloudy = "Partially cloudy"
    case rainOvercast = "Rain, Overcast"
    case rainPartiallyCloudy = "Rain, Partially cloudy"
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
    case fog = "fog"
}

enum Source: String, Codable {
    case comb = "comb"
    case fcst = "fcst"
    case obs = "obs"
}

enum ID: String, Codable {
    case d4699 = "D4699"
    case d8868 = "D8868"
    case kgai = "KGAI"
    case kiad = "KIAD"
    case kjyo = "KJYO"
    case va060 = "VA060"
}

// MARK: - Station
struct Station: Codable {
    let distance: Int
    let latitude, longitude: Double
    let useCount: Int
    let id: ID
    let name: String
    let quality, contribution: Int
}

extension ID {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        if let idValue = ID(rawValue: rawValue) {
            self = idValue
        } else {

            self = .d4699 // Veya başka bir değer
        }
    }
}


struct HourlyConditions: Codable {
   
    let temp: Double?

    let icon: Icon?
 
}
