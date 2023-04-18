//
//  File.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

extension Binding {
    
    init<S: Router>(selected: Transition?, option: Transition, value: Binding<Screen<S>?>) where Value == S? {
        self.init {
            guard let selectedStyle = selected else { return nil }
            return selectedStyle == option ? value.wrappedValue?.view : nil
        } set: { _ in
            value.wrappedValue = nil
        }
    }
    
    init(option: AlertOption) where Value == Bool {
        self.init {
            option == .alert || option == .confirmationDialog ? true : false
        } set: { _ in
            
        }

    }
}
