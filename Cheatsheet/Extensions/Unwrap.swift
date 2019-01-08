//
//  Unwrap.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 9/15/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import Foundation

public extension Optional {
    public func unwrap(_ closure: (_ value: Wrapped) -> Void) {
        switch self {
        case .some(let value):
            closure(value)
        default:
            break
        }
    }
}
