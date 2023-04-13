//
//  NavifyStack.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

struct NavifyStack<D: Router, Content: View>: View {
    
    // MARK: - Binding properties
    @Binding var screens: [Screen<D>]
    
    // MARK: - ViewBuilder properties
    @ViewBuilder var content: Content
        
    // MARK: - State properties
    /// Includes the path of the NavigationStack
    @State private var path: NavigationPath = .init()
    /// Includes the path of the path from the NavigationStack. This variable is needed to track and compare the path wit other elements from the path of the NavigationStack
    @State private var pathStack: [Screen<D>] = []
    /// Is equal the screen that has a '.present' style
    @State private var latestScreen: Screen<D>? = nil
    
    init(
        screens: Binding<[Screen<D>]>,
        @ViewBuilder content: @escaping() -> Content
    ) {
        self._screens = screens
        self.content = content()
    }
    
    // MARK: - Body
    var body: some View {
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
        .present(latestScreen: $latestScreen, destination: { destination in
            NavifyStackContainerView(latestScreen: $latestScreen, screens: $screens) {
                destination.viewForDestination()
            }
        })
        .presentFullScreen(latestScreen: $latestScreen, destination: { destination in
            NavifyStackContainerView(latestScreen: $latestScreen, screens: $screens) {
                destination.viewForDestination()
            }
        })
        .onChange(of: screens) { newValue in
            print("currentScreens", screens.map { $0.view})
            if let screen = newValue.last {
                
                if let index = newValue.lazy.firstIndex(where: { $0.id == screen.id }) {
                    if newValue.count > 1 {
                        
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
            } else {
                if screens.isEmpty {
                    latestScreen = nil
                }
            }
            popToRoot()
        }
    }
    
    // MARK: - Methods
    /// Pops to root when every element is deleted from the path and pathStack
    private func popToRoot() {
        if screens.count == 0 {
            latestScreen = nil
            pathStack.removeLast(pathStack.count)
            path.removeLast(path.count)
        }
    }
    
}

