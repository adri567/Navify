//
//  Detents.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

import SwiftUI

public struct Detents {
    
    // MARK: - Properties
    var presentationDragIndicator: Visibility
    var presentationDetents: Set<PresentationDetent>
    
    public init(
        presentationDragIndicator: Visibility = .automatic,
        presentationDetents: Set<PresentationDetent> = [.large])
    {
        self.presentationDragIndicator = presentationDragIndicator
        self.presentationDetents = presentationDetents
    }
}
