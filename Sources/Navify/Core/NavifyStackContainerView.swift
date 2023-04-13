//
//  NavifyStackContainerView.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

struct NavifyStackContainerView<D: Router, Content: View>: View {
    
    // MARK: - State properties
    @State private var didRemovedScreen: Bool = false
    
    // MARK: - Init properties
    var latestScreen: Binding<Screen<D>?>
    var screens: Binding<[Screen<D>]>
    let content: Content
    
    public init(
        latestScreen: Binding<Screen<D>?>,
        screens: Binding<[Screen<D>]>,
        @ViewBuilder _ content: @escaping() -> Content
    ) {
        self.latestScreen = latestScreen
        self.screens = screens
        self.content = content()
    }
    
    // MARK: - Body
    var body: some View {
        content
            .onDisappear {
                if !screens.isEmpty {
                    if didRemovedScreen {
                        screens.wrappedValue.removeLast()
                        latestScreen.wrappedValue = nil
                        didRemovedScreen = false
                    }
                }
            }
            .onChange(of: screens.wrappedValue, perform: { newValue in
                didRemovedScreen = false
            })
            .onAppear {
                if !didRemovedScreen {
                    didRemovedScreen = true
                }
            }
    }
}
