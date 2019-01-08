//
//  UICollectionView+Extensions.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 9/15/18.
//  Copyright © 2018 Prokhor Kharchenko. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
    public func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        let typeString = String(describing: type)
        let nib = UINib(nibName: typeString, bundle: .main)
        register(nib, forCellWithReuseIdentifier: typeString)
    }
    
    public func dequeue<Cell: UICollectionViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let typeString = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: typeString, for: indexPath) as! Cell
    }
}
