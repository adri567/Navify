//
//  AlertModifier.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    
    // MARK: - Properties
    var alert: Binding<NavifyAlert>
    
    // MARK: - Body
    func body(content: Content) -> some View {
        if alert.option.wrappedValue == .alert {
            content
                .alert(alert.title.wrappedValue, isPresented: alert.isPresenting) {
                    AnyView(alert.content.wrappedValue)
                } message: {
                    Text(alert.message.wrappedValue)
                }
        }
        
        if alert.option.wrappedValue == .confirmationDialog {
            if alert.message.wrappedValue.isEmpty {
                content
                    .confirmationDialog(alert.title.wrappedValue, isPresented: alert.isPresenting) {
                        AnyView(alert.content.wrappedValue)
                    }
            } else {
                content
                    .confirmationDialog(alert.title.wrappedValue, isPresented: alert.isPresenting) {
                        AnyView(alert.content.wrappedValue)
                    } message: {
                        Text(alert.message.wrappedValue)
                    }

            }
        }
    }
}
