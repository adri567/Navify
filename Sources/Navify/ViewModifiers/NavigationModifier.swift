//
//  NavigationModifier.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

struct NavigationModifier<H: Hashable, V: View>: ViewModifier {
    
    // MARK: - Properties
    let data: H.Type
    let destination: (H) -> V
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: data) { destination in
                self.destination(destination)
            }
    }
}
