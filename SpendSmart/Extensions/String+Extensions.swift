//
//  String+Extensions.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 9/30/23.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
