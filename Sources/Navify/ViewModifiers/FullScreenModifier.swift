//
//  FullScreenModifier.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

struct FullScreenModifier<H: Hashable, V: View, S: Router>: ViewModifier {
    
    // MARK: - Properties
    var latestScreen: Binding<Screen<S>?>
    let destination: (H) -> V
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .fullScreenCover(item: Binding(selected: latestScreen.wrappedValue?.style.transition, option: .presentFullScreen, value: latestScreen), content: { destination in
                if let view = destination as? H {
                    self.destination(view)
                        .background(.red)
                }
            })
    }
}
