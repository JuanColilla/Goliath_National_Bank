//
//  extension+String.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 11/10/21.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
