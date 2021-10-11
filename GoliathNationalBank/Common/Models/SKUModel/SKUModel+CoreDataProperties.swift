//
//  SKUModel+CoreDataProperties.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//
//

import Foundation
import CoreData

// CoreData Properties
extension SKUModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SKUModel> {
        return NSFetchRequest<SKUModel>(entityName: "SKUModel")
    }

    @NSManaged public var amount: String
    @NSManaged public var currency: String
    @NSManaged public var sku: String

}

extension SKUModel : Identifiable {

}
