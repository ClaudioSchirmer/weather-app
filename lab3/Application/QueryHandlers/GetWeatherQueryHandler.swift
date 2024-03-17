//
//  GetWeatherCommandHandler.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-15.
//

import Foundation

class GetWeatherQueryHandler : QueryHandler {
    typealias TCommand = GetWeatherQuery
    
    private var notification = Notification(context: "GetWeatherQueryHandler")
    
    func execute(query: GetWeatherQuery) async throws -> WeatherDTO {
        
        var httpClient = HttpClient(scheme: HttpClientScheme.Https, host: "api.weatherapi.com", defaultPath: "/v1/current.json")
        httpClient.addDefaultQueryParameter(key: "key", value: "923298f737804f9d99a143207241403")
        httpClient.addDefaultQueryParameter(key: "aqi", value: "no")
        
        guard let location = query.location else {
            notification.addMessage(field: "location", message: "Location is required.")
            throw NotificationError(notification: notification)
        }
        
        if (location.isEmpty) {
            notification.addMessage(field: "location", message: "Location is required.")
            throw NotificationError(notification: notification)
        }
        
        let httpResponse = await httpClient.getJson(additionalQueryParameters: ["q" : location])
        
        guard httpResponse.successfullyReceived() else {
            notification.addMessage(message: "Your request cannot be completed (\(httpResponse.statusCode)). Try again with another location.")
            throw NotificationError(notification: notification)
        }
        
        if (httpResponse.data == nil) {
            notification.addMessage(message: "Weatherapi is not responding.")
        }
        
        var weatherDTO: WeatherDTO? = nil
        let decoder = JSONDecoder()
        do {
            weatherDTO = try decoder.decode(WeatherDTO.self, from: httpResponse.data!)
        } catch let newError {
            notification.addMessage(message: "Weatherapi has responded with unexpected JSON (\(newError)).")
        }
        
        if (!notification.messages.isEmpty) {
            throw NotificationError(notification: notification)
        }
        
        return weatherDTO!
    }
}
