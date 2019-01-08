//
//  GenericCollectionViewCellFactory.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 01/08/19.
//  Copyright © 2019 Prokhor Kharchenko. All rights reserved.
//

import UIKit
import RxDataSources

public protocol GenericCollectionViewCellFactoryType {
    associatedtype Section: SectionModelType
    
    func createCell(dataSource: CollectionViewSectionedDataSource<Section>, collectionView: UICollectionView, indexPath: IndexPath, item: Section.Item) -> UICollectionViewCell
}

public final class AnyGenericCollectionViewCellFactory<S: SectionModelType>: GenericCollectionViewCellFactoryType {
    public typealias Section = S
    
    private let invokeCreateCell: (CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, S.Item) -> UICollectionViewCell
    
    public init<O: GenericCollectionViewCellFactoryType>(factory: O) where O.Section == S {
        invokeCreateCell = factory.createCell
    }

    public func createCell(dataSource: CollectionViewSectionedDataSource<S>, collectionView: UICollectionView, indexPath: IndexPath, item: S.Item) -> UICollectionViewCell {
        return invokeCreateCell(dataSource, collectionView, indexPath,item)
    }
}

public final class GenericCollectionViewCellFactory<SectionItem, Item>: GenericCollectionViewCellFactoryType {
    public typealias Section = SectionModel<SectionItem, Item>
    public typealias CreateCellAction = (CollectionViewSectionedDataSource<Section>, UICollectionView, IndexPath, Section.Item) -> UICollectionViewCell

    private let shouldCreateCell: CreateCellAction

    public init(createCellAction: @escaping CreateCellAction) {
        self.shouldCreateCell = createCellAction
    }

    public func createCell(dataSource: CollectionViewSectionedDataSource<SectionModel<SectionItem, Item>>, collectionView: UICollectionView, indexPath: IndexPath, item: Section.Item) -> UICollectionViewCell {
        return shouldCreateCell(dataSource, collectionView, indexPath, item)
    }
}
