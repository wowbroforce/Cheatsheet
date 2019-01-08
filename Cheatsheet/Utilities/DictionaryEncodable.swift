//
//  DictionaryEncodable.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 10/18/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import Foundation

public protocol DictionaryEncodable: Encodable { }

public extension DictionaryEncodable {
    public func toDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        } else {
            // Fallback on earlier versions
        }
        guard
            let model = try? encoder.encode(self),
            let object = try? JSONSerialization.jsonObject(with: model, options: []),
            let dictionary = object as? [String: Any]
        else {
            return nil
        }
        return dictionary
    }
}
