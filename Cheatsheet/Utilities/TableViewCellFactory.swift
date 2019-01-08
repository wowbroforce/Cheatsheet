//
//  TableViewCellFactory.swift
//  Cheatsheet
//
//  Created by Prokhor Kharchenko on 01/08/19.
//  Copyright © 2019 Prokhor Kharchenko. All rights reserved.
//

import Foundation
import UIKit

public final class TableViewCellFactory {
    private var mappings: [AnyMapping] = []

    public func addMapping<Model, Cell>(
        condition: @escaping (Model) -> Bool,
        update: @escaping (Model, Cell) -> Void
    ) {
        let mapping = Mapping<Model, Cell>(condition: condition, update: update)
        let anyMapping = AnyMapping(mapping: mapping)
        
        mappings.append(anyMapping)
    }
    
    public func createCell<Model>(tableView: UITableView, indexPath: IndexPath, model: Model) throws -> UITableViewCell {
        guard let mapping = mappings.first(where: { $0.isModelOfType(model) && $0.condition(model) }) else {
            throw Errors.mappingNotFound
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: mapping.identifier, for: indexPath)
        mapping.update(model, cell)
        return cell
    }
    
    public enum Errors: LocalizedError {
        case mappingNotFound
        case error
    }
}

public protocol MappingType {
    associatedtype Model
}

public class Mapping<Model, Cell>: MappingType {
    public let condition: (Model) -> Bool
    public let update: (Model, Cell) -> Void
    public let isModelOfType: (Model) -> Bool
    public let identifier: String

    public init(condition: @escaping (Model) -> Bool = { _ in true }, update: @escaping (Model, Cell) -> Void) {
        self.condition = condition
        self.update = update
        self.identifier = String(describing: Cell.self)
        
        isModelOfType = { model in
            return type(of: model) == Model.self
        }
    }
}

public class AnyMapping {
    public let identifier: String
    public let isModelOfType: (Any) -> Bool
    public let condition: (Any) -> Bool
    public let update: (Any, Any) -> Void
    
    public init<Model, Cell>(mapping: Mapping<Model, Cell>) {
        isModelOfType = { mapping.isModelOfType($0 as! Model) }
        condition = { mapping.condition($0 as! Model) }
        update = { mapping.update($0 as! Model, $1 as! Cell) }
        identifier = mapping.identifier
    }
}
