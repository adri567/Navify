//
//  Types.swift
//  
//
//  Created by Adrian Suthold on 12.04.23.
//

public struct Types {
    
    var transition: Transition
    
    var detents: Detents
    
    init(segue: Transition) {
        self.transition = segue
        detents = Detents()
    }
    
    init(
        segue: Transition,
        detents: Detents
    ) {
        self.transition = segue
        self.detents = detents
    }
}
