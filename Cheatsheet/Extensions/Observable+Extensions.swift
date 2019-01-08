//
//  Observable+Extensions.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 8/26/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public extension SharedSequenceConvertibleType {
    public func transform<T>(to newValue: T) -> SharedSequence<SharingStrategy, T> {
        return map { _ -> T in newValue }
    }
}

public extension ObservableType {
    public func transform<T>(to newValue: T) -> Observable<T> {
        return map { _ -> T in newValue }
    }
}

public extension ObservableType where E == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}

public extension ObservableType where E == (Bool, Bool) {
    /// Boolean and operator
    public func and() -> Observable<Bool> {
        return self.map { $0 && $1 }
    }
}

public extension SharedSequenceConvertibleType where E == Bool {
    /// Boolean not operator
    public func not() -> SharedSequence<SharingStrategy, E> {
        return self.map(!)
    }
}

public extension SharedSequenceConvertibleType where E == (Bool, Bool) {
    /// Boolean and operator
    public func and() -> SharedSequence<SharingStrategy, Bool> {
        return self.map { $0 && $1 }
    }
}

public extension SharedSequenceConvertibleType {
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

public extension ObservableType {
    public func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    public func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait {
    public func transform<T>(to newValue: T) -> Maybe<T> {
        return map { _ -> T in newValue }
    }

}

public extension PrimitiveSequenceType where TraitType == SingleTrait {
    public func transform<T>(to newValue: T) -> Single<T> {
        return map { _ -> T in newValue }
    }
}

public extension PrimitiveSequenceType {
    public func asDriverOnErrorJustComplete() -> Driver<ElementType> {
        return primitiveSequence.asDriver { _ in
            return .empty()
        }
    }
}
