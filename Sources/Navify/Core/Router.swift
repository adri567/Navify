//
//  Router.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

public protocol Router: Identifiable, Hashable {
    
    /// In order to navigate to a specific view, we need a destination. The destination should be the struct Destintaion
    //    associatedtype D
    
    /// Conforms to view
    associatedtype V:View
    
    /// With this method we get out expected view that we requested in the parameter
    /// - Parameter destination: Should be the Destintaion struct, that we can switch between the different views
    /// - Returns: The requested view
    @ViewBuilder func viewForDestination() -> V
}
