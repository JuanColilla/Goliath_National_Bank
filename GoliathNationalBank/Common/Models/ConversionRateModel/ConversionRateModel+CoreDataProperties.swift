//
//  ConversionRateModel+CoreDataProperties.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//
//

import Foundation
import CoreData


extension ConversionRateModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConversionRateModel> {
        return NSFetchRequest<ConversionRateModel>(entityName: "ConversionRateModel")
    }

    @NSManaged public var from: String
    @NSManaged public var rate: String
    @NSManaged public var to: String

}

extension ConversionRateModel : Identifiable {

}
