//
//  Types.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

public struct Types {
    
    // MARK: - Properties
    var transition: Transition
    var detents: Detents
    
    public init(
        segue: Transition,
        detents: Detents = Detents()
    ) {
        self.transition = segue
        self.detents = detents
    }
}
