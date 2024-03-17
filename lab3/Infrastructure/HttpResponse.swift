//
//  HttpResponse.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-17.
//

import Foundation

struct HttpResponse {
    let statusCode: Int
    let data: Data?
    let error: Any?
    
    func successfullyReceived() -> Bool {
        (200...299).contains(statusCode)
    }
}
