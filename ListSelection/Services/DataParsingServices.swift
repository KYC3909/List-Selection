//
//  DataParsingServices.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import Foundation

protocol Parser: AnyObject {
    func decode<T:Decodable>(_ data: Data, _ responseType: T.Type) throws -> T
}

final class JSONParser: Parser  {
    func decode<T:Decodable>(_ data: Data, _ responseType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
