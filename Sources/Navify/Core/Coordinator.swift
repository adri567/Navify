//
//  Coordinator.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

protocol Coordinator {
        
    associatedtype R: Router
    
    /// The path that every coordinator should have, represented as an array of `Screen`s.
    var screens: [Screen<R>] { get set }
    
    var view: AnyView { get set }
    
    /// Pop to the root view of the navigation stack.
    func popToRoot() -> Void
    
    /// Navigates to a specific view or screen identified by a router and a segue style.
    /// - Parameters:
    ///   - view: The destination view or screen identified by a router.
    ///   - style: The style of the segue used to present the destination view or screen.
    func navigateTo(_ view: R, style: Types)
    
    func presentAlert(of type: AlertOption, and alertContent: @escaping () -> some View)
}

extension Coordinator {
    
    var view: AnyView {
        get {
            return AnyView(EmptyView())
        }
        set {}
    }
    func presentAlert(of type: AlertOption, and alertContent: @escaping () -> some View) {}
}

