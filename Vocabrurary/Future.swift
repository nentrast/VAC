//
//  Future.swift
//  Future
//
//  Created by Alexandr Lobanov on 22.06.2020.
//  Copyright © 2020 Alexandr Lobanov. All rights reserved.
//

import Foundation

class Promise<Value>: Future<Value> {
    init(value: Value? = nil) {
        super.init()
        result = value.map(Result.success)
    }
    
    func resolve(with value: Value) {
        result = .success(value)
    }
    
    func reject(with error: Error) {
        result = .failure(error)
    }
}

class Future<Value> {
    typealias Result = Swift.Result<Value, Error>
    
    fileprivate var result: Result? {
        didSet {
            result.map(report)
        }
    }
    
    private var callbacks = [(Result) -> Void]()

    func observe(using callback: @escaping (Result) -> Void) {
        if let result = result {
            return callback(result)
        }
        
        callbacks.append(callback)
    }
    
    func report(result: Result) {
        callbacks.forEach({ $0(result)})
        callbacks.removeAll()
    }
}

extension Future {
    func retry<T>(promiseClossure: @escaping (() -> Future<T>), maxAtempts: Int, delay: TimeInterval, queue: DispatchQueue = .main) -> Future<T> {
        let promise = Promise<T>()
        promiseClossure().observe { (result) in
            switch result {
            case .failure(let error):
                    print("Attmepts: \(maxAtempts)")
                if maxAtempts == 1 {
                    promise.reject(with: error)
                } else {
                    queue.asyncAfter(deadline: .now() + delay) {
                        self.retry(promiseClossure: promiseClossure, maxAtempts: maxAtempts - 1, delay: delay).observe { (result) in
                            switch result {
                            case .failure(let error):
                                promise.reject(with: error)
                            case .success(let value):
                                promise.resolve(with: value)
                            }
                        }
                    }
                }
            case .success(let value):
                promise.resolve(with: value)
            }
            
        }
        
        return promise
    }
}

extension Future {
    func wait(delay: TimeInterval, queue: DispatchQueue) -> Future<Value> {
        chained { (value)  in
            let promise = Promise<Value>()
            queue.asyncAfter(deadline: .now() + delay) {
                promise.resolve(with: value)
            }
            return promise
        }
    }
}

extension Future {
    func chained<T>(using closure: @escaping(Value) throws -> Future<T>) -> Future<T> {
        let promise = Promise<T>()
        
        observe { (result) in
            switch result {
            case .success(let value):
                do {
                    let future = try closure(value)
                    future.observe { (result) in
                        switch result {
                        case .failure(let error):
                            promise.reject(with: error)
                        case .success(let value):
                            promise.resolve(with: value)
                        }
                    }
                } catch let error {
                    promise.reject(with: error)
                }
            case .failure(let error):
                promise.reject(with: error)
            }
        }
        
        return promise
    }
}

protocol Saveable {
    
}


protocol Database {
    func save(with object: Saveable, completion: () -> Void)
}

extension Future where Value: Saveable {
    func saved(in database: Database) -> Future<Value> {
        chained { (value)  in
            let promise = Promise<Value>()
            database.save(with: value) {
                promise.resolve(with: value)
            }
            
            return promise
        }
    }
}

extension Array where Element == Saveable {
    func save(database: Database) -> Future<Element> {
        let promise = Promise<Element>()
        
        forEach { (element) in
            database.save(with: element) {
                promise.resolve(with: element)
            }
        }
        
        return promise
    }
}

extension Future {
    func transformed<T>(with closure: @escaping (Value) throws -> T) -> Future<T> {
         chained { value in
             try Promise(value: closure(value))
        }
    }
}

extension Future where Value == Data {
    func decoded<T: Decodable>(as type: T.Type = T.self, using decoder: JSONDecoder = .init()) -> Future<T> {
        transformed { (data) in
            try decoder.decode(type, from: data)
        }
    }
}

enum Er: Error {
    case fake
}
 
extension URLSession {
    func request(url: URL) -> Future<Data> {
        let promise = Promise<Data>()
        
        let task = dataTask(with: url) { (data, response, error) in
            if let error = error {
                promise.reject(with: error)
            } else {
                if Bool.random() {
                    print("Sended true")
                    promise.resolve(with: data ?? Data())
                } else {
                    print("Sended fake")
                    promise.reject(with: Er.fake)
                }
            }
        }
        
        task.resume()
        
        return promise
    }
}
