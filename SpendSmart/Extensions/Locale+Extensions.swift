//
//  Locale+Extensions.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 9/30/23.
//

import Foundation

extension Locale {
    
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
}
