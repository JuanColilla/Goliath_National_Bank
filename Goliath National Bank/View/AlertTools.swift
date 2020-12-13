//
//  AlertTools.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//
//

import Foundation
import UIKit

extension UIViewController {
    
    // Alert for show error
    func showErrorAlert(message: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            
            let buttonOne = UIAlertAction(title: "OK", style: .default)  {
                UIAlertAction in
            }
            alert.addAction(buttonOne)
            
            self.present(alert, animated: true)
        }
        
    }
    
    // Alert with completionHandler to control actions, with optional one or two buttons
    func showErrorAlertCompletion(message: String, completion: @escaping (Bool) -> ()) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
            
            let buttonOne = UIAlertAction(title: "OK", style: .default)  {
                UIAlertAction in
                completion(true)
            }
            alert.addAction(buttonOne)
            
            self.present(alert, animated: true)
        }
    }
    
    // Alert for show some information
    func showInfoAlert(title: String, message: String, buttonOneText: String, style: UIAlertController.Style) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: style)
            
            let buttonOne = UIAlertAction(title: buttonOneText, style: .default)
            alert.addAction(buttonOne)
            
            self.present(alert, animated: true)
        }
    }
    
    // Alert with completionHandler to control actions, with optional one or two buttons
    func showAlert(title: String = "Alerta", message: String, style: UIAlertController.Style, twoButtons: Bool = false, buttonOneText: String, buttonTwoText: String = "OK", completion: @escaping (Bool) -> ()) {
        
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: style)
            
            let buttonOne = UIAlertAction(title: buttonOneText, style: .default) {
                UIAlertAction in
                completion(true)
            }
            alert.addAction(buttonOne)
            
            if twoButtons {
                let buttonTwo = UIAlertAction(title: buttonTwoText, style: .default) {
                    UIAlertAction in
                    completion(false)
                }
                alert.addAction(buttonTwo)
            }
            
            self.present(alert, animated: true)
        }
        
    }
    
}


