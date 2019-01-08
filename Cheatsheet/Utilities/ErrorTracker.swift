//
//  ErrorTracker.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 8/26/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public class ErrorTracker: SharedSequenceConvertibleType {
    public typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<Error>()
    
    public init() { }
    
    public func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.E> {
        return source.asObservable().do(onError: onError)
    }
    
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }
    
    public func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }
    
    private func onError(_ error: Error) {
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}

public extension ObservableConvertibleType {
    public func trackError(_ errorTracker: ErrorTracker) -> Observable<E> {
        return errorTracker.trackError(from: self)
    }
}
