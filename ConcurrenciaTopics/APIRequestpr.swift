//
//  APIRequestpr.swift
//  ConcurrenciaTopics
//
//  Created by Ricardo Hernandez on 24/1/21.
//

import Foundation
let apiUrl = "https://mdiscourse.keepcoding.io"

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var body: [String: Any] { get }
    var headers: [String: String] { get }
}

//Implementacion del protocolo
extension APIRequest {
    var bURL: URL {
        guard let bURL = URL(string: apiUrl) else {
            fatalError("URL NOT VALID")
        }
        return bURL
    }
    
    func requestWithBaseURL() -> URLRequest {
        
        
        //definimos cual es la url con el recurso a llamar
        let url = bURL.appendingPathComponent(path)
        
        //si tenemos parámetros la construimos con ellos
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Not able to create components")
        }
        if !parameters.isEmpty{
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        <#statements#>
        }
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        //AHORA a partir de la URL, podemos construir nuestro URLRequest, que lo necesitamos para crear last de URLSession
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        if !body.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        //Aqui definimos las cabezaras de nuestra petición
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Api-key")
        request.addValue("riheca34", forHTTPHeaderField: "Api-Username")
        
        return request
    }
    
}
