//
//  HttpClientError.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

enum HttpClientError : String, Error {
    case URLEncodedError = "Cannot parse String to URL"
}
