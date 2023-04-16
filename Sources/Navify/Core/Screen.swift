//
//  Screen.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

/// A struct representing a screen that can be displayed by a `NavigationCoordinator`.
/// The screen contains information about the view to display and the transition style
/// to use when presenting it.
///
/// - Note: The generic type `D` must conform to `NavigationRouter`.
///
/// - Parameters:
///   - id: A unique identifier for the screen. Defaults to a new UUID.
///   - style: The transition style to use when presenting the view.
///   - view: The view to display.
public struct Screen<D: Router>: Identifiable, Hashable {
    public static func == (lhs: Screen<D>, rhs: Screen<D>) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// A unique identifier for the screen.
    public var id: String = UUID().uuidString
    /// The transition style to use when presenting the view.
    var style: Types
    /// The view to display.
    let view: D
    
    public init(
        style: Types,
        view: D
    ) {
        self.style = style
        self.view = view
    }
}
