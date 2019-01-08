//
//  Rx+NSKeyValueObservation.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 9/16/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import Foundation
import RxSwift

public extension NSKeyValueObservation {
    public func disposed(by bag: DisposeBag) {
        Disposables.create { self.invalidate() }.disposed(by: bag)
    }
}
