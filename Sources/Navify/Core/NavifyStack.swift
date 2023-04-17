//
//  NavifyStack.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI


public struct NavifyStack<D: Router, Content: View>: View {
    
    // MARK: - Binding properties
    @Binding var screens: [Screen<D>]
    
    @Binding var alert: NavifyAlert
    
    // MARK: - ViewBuilder properties
    @ViewBuilder var content: Content
        
    // MARK: - State properties
    /// Includes the path of the NavigationStack
    @State private var path: NavigationPath = .init()
    /// Includes the path of the path from the NavigationStack. This variable is needed to track and compare the path wit other elements from the path of the NavigationStack
    @State private var pathStack: [Screen<D>] = []
    /// Is equal the screen that has a '.present' style
    @State private var latestScreen: Screen<D>? = nil
    
    public init(
        screens: Binding<[Screen<D>]>,
        alert: Binding<NavifyAlert> = .constant(.init(title: "")),
        @ViewBuilder content: @escaping() -> Content
    ) {
        self._screens = screens
        self._alert = alert
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        NavigationStack(path: $path) {
            content
                .navigation(data: D.self) { destination in
                    destination.viewForDestination()
                        .onDisappear {
                            /// If 'path.count' is less than 'pathStack.count', we remove the last element from 'screens' and 'pathStack' to make them equal to the path of the NavigationStack
                            if path.count < pathStack.count {
                                screens.removeLast()
                                pathStack.removeLast()
                            }
                        }
                }
        }
        .presentSheet(latestScreen: $latestScreen, destination: { destination in
            NavifyStackContainerView(latestScreen: $latestScreen, screens: $screens) {
                destination.viewForDestination()
            }
        })
        .presentFullScreen(latestScreen: $latestScreen, destination: { destination in
            NavifyStackContainerView(latestScreen: $latestScreen, screens: $screens) {
                destination.viewForDestination()
            }
        })
        .presentAlert(alert: $alert)
        .onChange(of: screens) { newValue in
            
            if let screen = newValue.last {
                
                if let index = newValue.lazy.firstIndex(where: { $0.id == screen.id }) {
                    if newValue.count > 1 {
                        /// If the transition is equal to 'present' and 'presentFullScreen' we set 'latestScreen' to nil and removing the previous screen. This is needed, otherwise we have a a unvalid view in our screen path.
                        if screens[index - 1].style.transition == .present ||
                            screens[index - 1].style.transition == .presentFullScreen {
                            latestScreen = nil
                            screens.remove(at: index - 1)
                        }
                    }
                }
                
                if screen.style.transition == .push {
                    /// This needs to be inside a task; otherwise, it can lead to unexpected behavior of the navigation.
                    Task {
                        /// To avoid duplicated, we check if screen already exist in the pathStack
                        if !pathStack.contains(screen) {
                            pathStack.append(screen)
                            path.append(screen.view)
                        }
                    }
                }
                
                if screen.style.transition == .present ||
                    screen.style.transition == .presentFullScreen {
                    /// Set 'latestScreen' to the last screen of screens
                    /// Needs to be inside a Task, otherwise the presentation style is stuck on the previous presentation style
                    Task {
                        latestScreen = screen
                    }
                }
            }
            
            popToRoot()
        }
    }
    
    // MARK: - Methods
    /// Pops to root when every element is deleted from the path and pathStack
    private func popToRoot() {
        if screens.isEmpty {
            if latestScreen != nil {
                latestScreen = nil
            }
            pathStack.removeLast(pathStack.count)
            path.removeLast(path.count)
        }
    }
    
}

