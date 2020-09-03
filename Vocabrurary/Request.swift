//
//  Request.swift
//  Vocabrurary
//
//  Created by Alexandr Lobanov on 07.07.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Combine
import Foundation

class Request {
//https://api.unsplash.com/photos/?client_id=yXxMHLgvTPcDPhHgn3Zb1EN4sbam0YmqZTMjRgttLGQ
    ///yXxMHLgvTPcDPhHgn3Zb1EN4sbam0YmqZTMjRgttLGQ
    func test() {
        
        let request = URLRequest(url: URL(string: "https://api.unsplash.com/photos/?client_id=yXxMHLgvTPcDPhHgn3Zb1EN4sbam0YmqZTMjRgttLGQ")!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        }
        
        task.resume()
    }
}

class ApiReequest {
    struct Response<T> { // 1
         let value: T
         let response: URLResponse
     }
    
    func run<T: Decodable>(objectType: T.Type) -> AnyPublisher<ApiReequest.Response<T>, Error> {
        let request = URLRequest(url: URL(string: "https://api.unsplash.com/photos/?client_id=yXxMHLgvTPcDPhHgn3Zb1EN4sbam0YmqZTMjRgttLGQ")!)
        
        return URLSession.shared.dataTaskPublisher(for: request).tryMap { (result) -> Response<T> in
            let value = try JSONDecoder().decode(T.self, from: result.data)
            return Response(value: value, response: result.response)
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}
