//
//  CurrencyConversor.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import Foundation


class CurrencyConversor {
    
    let EUR = Currency.EUR.rawValue
    let USD = Currency.USD.rawValue
    let AUD = Currency.AUD.rawValue
    let CAD = Currency.CAD.rawValue
    
    var ratios: [ConversionRateModel] = [ConversionRateModel]()
    
    var eur2usd: Double = 0.0
    var usd2eur: Double = 0.0
    
    var aud2cad: Double = 0.0
    var cad2aud: Double = 0.0
    
    var usd2aud: Double = 0.0
    var aud2usd: Double = 0.0
    
    var eur2aud: Double = 0.0
    var aud2eur: Double = 0.0
    
    var eur2cad: Double = 0.0
    var cad2eur: Double = 0.0
    
    var cad2usd: Double = 0.0
    var usd2cad: Double = 0.0
    
    
    init() {
        DataLoader.sharedInstance.loadConversionRates { (conversionRates) in
            self.ratios = conversionRates
        }
    }
    
    func loadRatios() {
        for ratio in self.ratios {
            if ratio.from == EUR && ratio.to == USD {
                self.eur2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == USD && ratio.to == EUR {
                self.usd2eur = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == CAD {
                self.aud2cad = Double(ratio.rate) ?? 0.0
            } else if ratio.from == CAD && ratio.to == AUD {
                self.cad2aud = Double(ratio.rate) ?? 0.0
            } else if ratio.from == USD && ratio.to == AUD {
                self.usd2aud = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            } else if ratio.from == AUD && ratio.to == USD {
                self.aud2usd = Double(ratio.rate) ?? 0.0
            }
        }
    }
    
    // Al principio iba a usar esta tabla de conversiones pero luego he visto que los ratios que la API devuelve no son siempre los mismos.
    func convertCurrency(inputCurrency: String, outputCurrency: String, amount: String) -> Double {
        switch (inputCurrency, outputCurrency) {
        case (EUR, USD):
            return Double(amount)! * eur2usd
        case (USD, EUR):
            return Double(amount)! * usd2eur
        case (EUR, AUD):
            return (Double(amount)! * eur2usd) * usd2aud
        case (AUD, EUR):
            return (Double(amount)! * aud2usd) * usd2eur
        case (EUR, CAD):
            return ((Double(amount)! * eur2usd) * usd2aud) * aud2cad
        case (CAD, EUR):
            return ((Double(amount)! * cad2aud) * aud2usd) * usd2eur
        case (USD, AUD):
            return Double(amount)! * usd2aud
        case (AUD, USD):
            return Double(amount)! * aud2usd
        case (USD, CAD):
            return (Double(amount)! * usd2aud) * aud2cad
        case (CAD, USD):
            return (Double(amount)! * cad2aud) * aud2usd
        case (AUD, CAD):
            return Double(amount)! * aud2cad
        case (CAD, AUD):
            return Double(amount)! * cad2aud
        default:
            return 0.0
        }
    }
    
    
}
