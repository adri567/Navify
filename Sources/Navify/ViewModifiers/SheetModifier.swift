//
//  SheetModifier.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

struct SheetModifier<H: Hashable, V: View, S: Router>: ViewModifier {
    
    // MARK: - Properties
    var latestScreen: Binding<Screen<S>?>
    let destination: (H) -> V
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .sheet(item: Binding(selected: latestScreen.wrappedValue?.style.transition, option: .present, value: latestScreen), content: { destination in
                if let view = destination as? H,
                   let detents = latestScreen.wrappedValue?.style.detents.presentationDetents,
                   let dragIndicator = latestScreen.wrappedValue?.style.detents.presentationDragIndicator {
                    self.destination(view)
                        .presentationDetents(detents)
                        .presentationDragIndicator(dragIndicator)
                }
            })
    }
}
