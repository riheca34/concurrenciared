//
//  ApiRequest.swift
//  ConcurrenciaTopics
//
//  Created by Ricardo Hernandez on 24/1/21.
//

import Foundation
import UIKit

enum SessionAPIError: Error {
    case emptyData
}
//Clase que llama al API

final class SessionaPI {
    lazy var session: URLSession = { () -> <#Result#> in 
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
}
