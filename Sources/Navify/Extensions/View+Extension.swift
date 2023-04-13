//
//  View+Extension.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

extension View {
    
    func navigation<H: Hashable, V: View>(data: H.Type, @ViewBuilder destination: @escaping (H) -> V) -> some View {
        self
            .modifier(NavigationModifier(data: data, destination: destination))
    }
    
    func present<V: View, S: Router>(latestScreen: Binding<Screen<S>?>, @ViewBuilder destination: @escaping (S) -> V) -> some View {
        self
            .modifier(SheetModifier(latestScreen: latestScreen, destination: destination))
    }
    
    func presentFullScreen<V: View, S: Router>(latestScreen: Binding<Screen<S>?>, @ViewBuilder destination: @escaping (S) -> V) -> some View {
        self
            .modifier(FullScreenModifier(latestScreen: latestScreen, destination: destination))
    }
    
    func alert() -> some View {
        self
            .modifier(AlertModifier())
    }
}
