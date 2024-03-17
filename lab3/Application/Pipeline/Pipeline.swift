//
//  Pipeline.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-15.
//

import Foundation

struct Pipeline {
    
    static func dispatch <TQuery: Query> (query: TQuery) async -> any PipelineResult {
        var pipelineResult: PipelineResult? = nil
        do {
            if let result = try await dispatchWithFactory(query: query) {
                pipelineResult = PipelineResultSuccess<TQuery>(result: result)
            }
        } catch let error as NotificationError {
            pipelineResult = PipelineResultNotification(notificationDTO: error.notification.toNotificationDTO())
        } catch let error {
            pipelineResult = PipelineResultError(error: error)
        }
        return pipelineResult!
    }    
    
    private static func dispatchWithFactory<T: Query> (query: T) async throws -> T.TResult? {
        switch type(of: query) {
        case is GetWeatherQuery.Type:
            return try await GetWeatherQueryHandler().execute(query: query as! GetWeatherQuery) as? T.TResult
        default:
            return nil
        }
    }
}
