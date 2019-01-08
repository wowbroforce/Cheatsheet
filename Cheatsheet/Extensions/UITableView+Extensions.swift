//
//  UITableView+Extensions.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 12/11/18.
//  Copyright © 2018 wowbroforce. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    public func register<Cell: UITableViewCell>(_ type: Cell.Type) {
        let typeString = String(describing: type)
        let nib = UINib(nibName: typeString, bundle: .main)
        register(nib, forCellReuseIdentifier: typeString)
    }
    
    public func dequeue<Cell: UITableViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let typeString = String(describing: type)
        return dequeueReusableCell(withIdentifier: typeString, for: indexPath) as! Cell
    }
}

