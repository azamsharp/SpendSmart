//
//  WithMessageWrapper.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 10/1/23.
//

import Foundation
import SwiftUI

struct WithMessageWrapper: ViewModifier {
    
    @State private var messageWrapper: MessageWrapper?
    
    func body(content: Content) -> some View {
        content.environment(\.showMessage) { messageType in
            print(messageType)
                messageWrapper = MessageWrapper(messageType: messageType)
            }
        .overlay(alignment: .bottom) {
            if messageWrapper != nil {
                MessageView(messageWrapper: $messageWrapper)
            }
        }
    }
}
