//
//  HttpClient.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import Foundation

struct HttpClient {
    private var urlComponents: URLComponents!
    private var urlRequest: URLRequest!
    private var headers: [String : String] = [:]
    private var defaultQueryParameters: [String : String ] = [:]
    
    init(scheme: HttpClientScheme, host: String, defaultPath: String? = nil) {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = scheme.rawValue
        self.urlComponents.host = host
        if let defaultPath = defaultPath {
            self.urlComponents.path = defaultPath
        }
    }
    
    mutating func addDefaultQueryParameter(key: String, value: String) {
        self.defaultQueryParameters[key] = value
    }
    
    mutating func postJson(path: String? = nil, body: Encodable) async -> HttpResponse {
        do {
            if let path = path {
                self.urlComponents.path = path
            }
            try prepareUrlRequest()
            self.urlRequest.setValue("application/json",forHTTPHeaderField: "Content-Type")
            self.urlRequest.httpBody = try JSONEncoder().encode(body)
            self.urlRequest.httpMethod = HttpMethod.Post.rawValue
            let (statusCode, data) = try await dispatch()
            return HttpResponse(statusCode: statusCode, data: data, error: nil)
        } catch let error {
            return HttpResponse(statusCode: 0, data: nil, error: error)
        }
    }
    
    mutating func getJson(path: String? = nil, additionalQueryParameters: [String : String] = [:]) async -> HttpResponse {
        do {
            if defaultQueryParameters.count > 0 || additionalQueryParameters.count > 0 {
                self.urlComponents.queryItems = []
                defaultQueryParameters.forEach { key, value in
                    self.urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
                }
                additionalQueryParameters.forEach { key, value in
                    self.urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
                }
            }
            if let path = path {
                self.urlComponents.path = path
            }
            try prepareUrlRequest()
            self.urlRequest.httpMethod = HttpMethod.Get.rawValue
            let (statusCode, data) = try await dispatch()
            return HttpResponse(statusCode: statusCode, data: data, error: nil)
        } catch let error {
            return HttpResponse(statusCode: 0, data: nil, error: error)
        }
    }
    
    private mutating func dispatch() async throws -> (Int, Data?) {
        headers.forEach { header in
            self.urlRequest.setValue(header.key, forHTTPHeaderField: header.value)
        }
        let (data, response) = try await URLSession.shared.data(for: self.urlRequest)
        var statusCode = 0
        if let httpResponse = response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
        }
        return (statusCode, data)
    }
    
    private mutating func prepareUrlRequest() throws {
        guard let url = self.urlComponents.url else {
            throw HttpClientError.URLEncodedError
        }
        self.urlRequest = URLRequest(url: url)
    }
}
