//
//  Notifications.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

struct Notification : Error {
    private(set) var messages: [NotificationMessage] = []
    let context: String
    
    mutating func addMessage(field: String? = nil, message: String) {
        self.messages.append(NotificationMessage(field: field, message: message))
    }

    init(context: String) {
        self.context = context
    }
    
    func toNotificationDTO() -> NotificationDTO {
        NotificationDTO(context: context, messages: messages)
    }
}
