//
//  Transition.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

/// The available segue options for navigation to another view.
public enum Transition {
    /// Use push segue to navigate to another view on the navigation stack.
    case push
    /// Use present segue to show another view modally.
    case present
    /// Use presentFullScreen segue to show another view modally in full screen.
    case presentFullScreen
}
