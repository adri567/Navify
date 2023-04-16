//
//  Coordinator.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

public protocol Coordinator {
        
    associatedtype R: Router
    
    /// The path that every coordinator should have, represented as an array of `Screen`s.
    var screens: [Screen<R>] { get set }
    
    /// Optional alert propertie for showing alerts and confirmation dialogs
    var alert: NavifyAlert { get set }
    
    /// Pop to the root view of the navigation stack.
    func popToRoot() -> Void
    
    /// Navigates to a specific view or screen identified by a router and a segue style.
    /// - Parameters:
    ///   - view: The destination view or screen identified by a router.
    ///   - style: The style of the segue used to present the destination view or screen.
    func navigateTo(_ view: R, style: Types)
    
    /// Presents a alert or a confirmationDialog
    /// - Parameter alert: Expecting a NavifyAlert for creating views inside the alert such as Text or Button
    func presentAlert(with alert: NavifyAlert)
}

public extension Coordinator {
    
    var alert: NavifyAlert {
        get {
            NavifyAlert(title: "")
        }
        set {}
    }
    
    func presentAlert(with alert: NavifyAlert) {}
}

