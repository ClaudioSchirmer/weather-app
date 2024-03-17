//
//  NotificationDTO.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-15.
//

import Foundation

struct NotificationDTO {
    let context: String
    let messages: [NotificationMessage]
    
    func getMessagesFor(field: String) -> [String] {
        messages.filter { notificationMessage in
            notificationMessage.field == field
        }.map { notificationMessage in
            notificationMessage.message
        }
    }
    
    func getGenericMessages() -> [String] {
        messages.filter { notificationMessage in
            notificationMessage.field == nil
        }.map { notificationMessage in
            notificationMessage.message
        }
    }
}
