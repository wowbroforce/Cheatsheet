//
//  RxDataSources+Extensions.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 11/29/18.
//  Copyright © 2018 wowbroforce. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

public extension SharedSequence {
    public func toSingleSectionModel<Section, ItemType>(model: Section) -> SharedSequence<S, [SectionModel<Section, ItemType>]> where E == Array<ItemType> {
        return map { [SectionModel(model: model, items: $0)] }
    }
    
    public func toSectionModel<Section, ItemType>() -> SharedSequence<S, [SectionModel<Section, ItemType>]> where E == [(Section, [ItemType])] {
        return map { sections in
            return sections.map { model, items in
                return SectionModel(model: model, items: items)
            }
        }
    }
}
