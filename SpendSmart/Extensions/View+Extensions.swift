//
//  View+Extensions.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 10/1/23.
//

import Foundation
import SwiftUI

extension View {
        
    func withMessageWrapper() -> some View {
        modifier(WithMessageWrapper())
    }
}
