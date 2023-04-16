//
//  Alert.swift
//  
//
//  Created by Adrian Suthold on 13.04.23.
//

import SwiftUI

public struct NavifyAlert {
    
    // MARK: - Properties
    var option: AlertOption
    var message: String
    var content: AnyView
    
    // MARK: - Body
    public init<T: View>(
        option: AlertOption = .alert,
        message: String = "",
        content: @escaping () -> T = { EmptyView() }
    ) {
        self.option = option
        self.message = message
        self.content = AnyView(content())
    }
    
}
